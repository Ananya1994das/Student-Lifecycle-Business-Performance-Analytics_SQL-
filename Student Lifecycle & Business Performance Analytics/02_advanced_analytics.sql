SET search_path TO core,public;
-- 1 Acquisition funnel
SELECT source,COUNT(*) leads,COUNT(*) FILTER(WHERE lead_status='Qualified') qualified,COUNT(*) FILTER(WHERE lead_status='Converted') converted,ROUND(100.0*COUNT(*) FILTER(WHERE lead_status='Converted')/NULLIF(COUNT(*),0),2) conversion_pct FROM leads GROUP BY source;
-- 2 Course completion
SELECT c.course_name,COUNT(e.enrollment_id) enrollments,COUNT(*) FILTER(WHERE e.enrollment_status='Completed') completed,ROUND(100.0*COUNT(*) FILTER(WHERE e.enrollment_status='Completed')/NULLIF(COUNT(e.enrollment_id),0),2) completion_pct FROM courses c LEFT JOIN enrollments e USING(course_id) GROUP BY c.course_id,c.course_name;
-- 3 Cash collection proxy, not accounting revenue
SELECT c.course_name,COALESCE(SUM(p.amount) FILTER(WHERE p.payment_status='Success'),0)-COALESCE(SUM(p.amount) FILTER(WHERE p.payment_status='Refunded'),0) net_cash_proxy FROM courses c LEFT JOIN enrollments e USING(course_id) LEFT JOIN payments p USING(enrollment_id) GROUP BY c.course_id,c.course_name;
-- 4 Attendance, pre-aggregated to avoid fanout
WITH a AS(SELECT enrollment_id,COUNT(*) FILTER(WHERE attendance_status='Present') present,COUNT(*) total FROM attendance GROUP BY enrollment_id) SELECT c.course_name,ROUND(100.0*SUM(a.present)/NULLIF(SUM(a.total),0),2) attendance_pct FROM a JOIN enrollments e USING(enrollment_id) JOIN courses c USING(course_id) GROUP BY c.course_name;
-- 5 Assessment scores
WITH s AS(SELECT enrollment_id,AVG(score) avg_score FROM assessment_submissions GROUP BY enrollment_id) SELECT c.course_name,ROUND(AVG(s.avg_score),2) avg_score FROM s JOIN enrollments e USING(enrollment_id) JOIN courses c USING(course_id) GROUP BY c.course_name;
-- 6 Rule-based at-risk learner flag

WITH activity_cutoff AS (
    SELECT MAX(event_timestamp) AS max_ts
    FROM learning_events
),

a AS (
    SELECT
        enrollment_id,
        AVG((attendance_status = 'Present')::INT) att
    FROM attendance
    GROUP BY enrollment_id
),

s AS (
    SELECT
        enrollment_id,
        AVG(score) score
    FROM assessment_submissions
    GROUP BY enrollment_id
),

l AS (
    SELECT
        le.enrollment_id,
        COUNT(*) FILTER (
            WHERE le.event_timestamp >= ac.max_ts - INTERVAL '30 days'
        ) recent_events
    FROM learning_events le
    CROSS JOIN activity_cutoff ac
    GROUP BY le.enrollment_id
)

SELECT
    e.enrollment_id,
    e.student_id,
    CASE
        WHEN COALESCE(a.att, 0) < 0.5
          OR COALESCE(s.score, 0) < 45
          OR COALESCE(l.recent_events, 0) < 2
        THEN 'High Risk'

        WHEN COALESCE(a.att, 0) < 0.7
          OR COALESCE(s.score, 0) < 60
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_segment

FROM enrollments e
LEFT JOIN a USING (enrollment_id)
LEFT JOIN s USING (enrollment_id)
LEFT JOIN l USING (enrollment_id);

-- 7 Monthly active learners
SELECT DATE_TRUNC('month',event_timestamp)::DATE month,COUNT(DISTINCT student_id) active_learners,COUNT(*) events FROM learning_events GROUP BY 1 ORDER BY 1;
-- 8 Placement and median CTC
SELECT c.course_name,COUNT(DISTINCT e.student_id) learners,COUNT(DISTINCT p.student_id) placed,ROUND(100.0*COUNT(DISTINCT p.student_id)/NULLIF(COUNT(DISTINCT e.student_id),0),2) placement_pct,ROUND(percentile_cont(.5) WITHIN GROUP(ORDER BY p.annual_ctc_lpa)::NUMERIC,2) median_ctc_lpa FROM courses c LEFT JOIN enrollments e USING(course_id) LEFT JOIN placements p ON p.student_id=e.student_id GROUP BY c.course_id,c.course_name;
-- 9 Ticket SLA
SELECT priority,COUNT(*) tickets,ROUND(AVG(EXTRACT(EPOCH FROM(resolved_at-created_at))/3600)::NUMERIC,2) avg_resolution_hours,ROUND(100.0*COUNT(*) FILTER(WHERE resolved_at IS NOT NULL)/COUNT(*),2) resolved_pct FROM support_tickets GROUP BY priority;
-- 10 JSONB event metadata
SELECT event_type,metadata->>'device' device,COUNT(*) events,ROUND(AVG((metadata->>'duration_sec')::INT),1) avg_duration FROM learning_events GROUP BY event_type,metadata->>'device';
-- 11 Instructor completion outcomes
SELECT i.instructor_name,c.course_name,COUNT(e.enrollment_id) learners,COUNT(*) FILTER(WHERE e.enrollment_status='Completed') completions FROM instructors i JOIN batches b USING(instructor_id) JOIN courses c USING(course_id) LEFT JOIN enrollments e USING(batch_id) GROUP BY i.instructor_id,i.instructor_name,c.course_name;
-- 12 Feedback quality
SELECT c.course_name,f.feedback_category,ROUND(AVG(f.rating),2) avg_rating,COUNT(*) responses FROM feedback f JOIN courses c USING(course_id) GROUP BY c.course_name,f.feedback_category;
-- 13 Career support use
SELECT session_type,session_status,COUNT(*) sessions,COUNT(DISTINCT student_id) learners FROM career_sessions GROUP BY session_type,session_status;
-- 14 Enrollment cohort completion
SELECT DATE_TRUNC('month',enrollment_date)::DATE cohort_month,COUNT(*) enrollments,COUNT(*) FILTER(WHERE enrollment_status='Completed') completed FROM enrollments GROUP BY 1 ORDER BY 1;
-- 15 Duplicate/invalid payment checks
SELECT transaction_ref,COUNT(*) FROM payments GROUP BY transaction_ref HAVING COUNT(*)>1;
SELECT COUNT(*) invalid_amounts FROM payments WHERE amount<=0;
