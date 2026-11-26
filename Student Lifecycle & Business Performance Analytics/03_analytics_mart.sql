CREATE TABLE IF NOT EXISTS mart.fact_enrollment_snapshot(enrollment_id INT PRIMARY KEY,student_id INT,course_id INT,batch_id INT,enrollment_date DATE,enrollment_status TEXT,successful_paid_amount NUMERIC(12,2),attendance_pct NUMERIC(6,2),avg_score NUMERIC(6,2),refreshed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE OR REPLACE PROCEDURE mart.refresh_enrollment_snapshot() LANGUAGE plpgsql AS $$
BEGIN
 TRUNCATE mart.fact_enrollment_snapshot;
 INSERT INTO mart.fact_enrollment_snapshot
 SELECT e.enrollment_id,e.student_id,e.course_id,e.batch_id,e.enrollment_date,e.enrollment_status,COALESCE(p.paid,0),a.att_pct,s.avg_score,CURRENT_TIMESTAMP
 FROM core.enrollments e
 LEFT JOIN(SELECT enrollment_id,SUM(amount) FILTER(WHERE payment_status='Success') paid FROM core.payments GROUP BY enrollment_id)p USING(enrollment_id)
 LEFT JOIN(SELECT enrollment_id,100.0*COUNT(*) FILTER(WHERE attendance_status='Present')/NULLIF(COUNT(*),0) att_pct FROM core.attendance GROUP BY enrollment_id)a USING(enrollment_id)
 LEFT JOIN(SELECT enrollment_id,AVG(score) avg_score FROM core.assessment_submissions GROUP BY enrollment_id)s USING(enrollment_id);
END $$;
CREATE MATERIALIZED VIEW IF NOT EXISTS mart.mv_course_kpis AS SELECT c.course_id,c.course_name,COUNT(e.enrollment_id) enrollments,COUNT(*) FILTER(WHERE e.enrollment_status='Completed') completed FROM core.courses c LEFT JOIN core.enrollments e USING(course_id) GROUP BY c.course_id,c.course_name;
CREATE UNIQUE INDEX IF NOT EXISTS ux_mv_course_kpis ON mart.mv_course_kpis(course_id);
-- After import: CALL mart.refresh_enrollment_snapshot(); REFRESH MATERIALIZED VIEW mart.mv_course_kpis;
