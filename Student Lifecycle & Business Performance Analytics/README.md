# 🎓 Advanced EdTech Analytics | PostgreSQL

### Transforming Educational Data into Actionable Business Insights

**An End-to-End PostgreSQL & SQL Analytics Project**

`PostgreSQL` `SQL` `pgAdmin 4` `Database Design` `Advanced SQL` `Business Analytics`

---

## 📌 Project Overview

How can an EdTech company understand its student acquisition funnel, monitor learning engagement, evaluate course performance, track payment collections, and measure placement outcomes?

This project explores these business questions through an end-to-end analytics solution developed using **PostgreSQL**.

Using 18 structured synthetic datasets and a relational database architecture, the project simulates an EdTech business ecosystem — covering the complete student journey from lead generation and enrollment to learning activities, assessments, career support, and placements.

The objective is to transform raw educational data into meaningful business insights through database management, advanced SQL analysis, data validation, and a reusable analytical reporting layer.

> **Dataset Disclaimer:** This project uses synthetic data generated for educational and portfolio purposes. It does not contain actual company, employee, or student records.

## 🎯 Business Objectives

- Analyse lead acquisition and student conversion performance.
- Evaluate enrollment trends and course completion rates.
- Monitor student attendance and learning engagement.
- Identify potentially at-risk learners using activity and performance indicators.
- Analyse payment collections and transaction patterns.
- Evaluate assessment performance and instructor outcomes.
- Track career support activities and placement outcomes.
- Monitor customer support performance and ticket resolution.
- Identify data quality issues and improve database reliability.

## 🛠️ Technology Stack

| Technology | Application |
|---|---|
| PostgreSQL | Relational database and SQL analytics |
| pgAdmin 4 | Database management and query execution |
| SQL | Data extraction, transformation and analysis |
| CSV | Dataset storage and data ingestion |
| GitHub | Version control and project documentation |

## 📂 Dataset Overview

The project contains 18 synthetic datasets representing different operational areas of an EdTech business.

| Business Area | Tables |
|---|---|
| Student & Acquisition | Students, Leads, Enrollments |
| Course Management | Courses, Batches, Instructors, Modules |
| Learning & Performance | Attendance, Assessments, Assessment Submissions, Learning Events |
| Financial Operations | Payments |
| Career & Placement | Mentors, Career Sessions, Placement Applications, Placements |
| Student Experience | Feedback, Support Tickets |

### Dataset Highlights

- **1,000** Student Records
- **1,800** Lead Records
- **946** Enrollment Records
- **1,883** Payment Records
- **9,460** Attendance Records

## 🏗️ Database Architecture

The database is organised into three schemas:

- **core:** Stores operational tables and relational data.
- **mart:** Contains analytical reporting tables and aggregated KPI outputs.
- **audit:** Supports audit-related database records.

### Database Design Features

- Primary and foreign key constraints
- Referential integrity
- Data validation constraints
- Database indexing
- JSONB data handling
- Relational table structures

## 🔍 SQL Analysis & Business Questions

The project includes 15 analytical SQL queries designed to answer important business questions across the EdTech domain.

| No. | Analysis | Business Purpose |
|---|---|---|
| 01 | Lead Acquisition Funnel | Understand lead-to-student conversion |
| 02 | Course Completion Analysis | Evaluate course completion performance |
| 03 | Payment Analysis | Examine payment collections and transaction patterns |
| 04 | Attendance Analysis | Monitor student attendance |
| 05 | Assessment Performance | Evaluate learner assessment scores |
| 06 | At-Risk Learner Identification | Identify learners requiring intervention |
| 07 | Monthly Active Learners | Track learning engagement trends |
| 08 | Placement Analysis | Evaluate placement outcomes |
| 09 | Support Ticket SLA | Monitor support resolution performance |
| 10 | JSONB Event Analysis | Analyse semi-structured learning events |
| 11 | Instructor Performance | Examine instructor-level outcomes |
| 12 | Feedback Analysis | Understand student satisfaction |
| 13 | Career Support Analysis | Evaluate career session utilisation |
| 14 | Enrollment Cohort Analysis | Compare cohort-level completion |
| 15 | Payment Data Quality | Identify potential payment data issues |

## 📊 Analytics Mart

To support reusable reporting and structured analysis, the project includes a dedicated analytical layer in the `mart` schema.

### Key Components

- `mart.fact_enrollment_snapshot` – Stores enrollment-level analytical snapshots.
- **Refresh Procedure** – Updates the analytical snapshot.
- `mart.mv_course_kpis` – Materialized view containing course-level KPI summaries.

This reporting layer separates analytical outputs from the operational data structure and makes frequently used business metrics easier to retrieve.

## 🔄 Project Workflow

1. **Dataset Preparation:** Prepared 18 synthetic CSV datasets representing EdTech business operations.
2. **Database Design:** Created relational tables with primary keys, foreign keys, constraints, and indexes.
3. **Data Ingestion:** Imported CSV datasets into PostgreSQL.
4. **Data Validation:** Checked data consistency, missing values, duplicates, and referential integrity.
5. **SQL Analysis:** Executed 15 analytical queries to answer business questions.
6. **Analytics Mart:** Developed reusable reporting structures and course-level KPI summaries.
7. **Business Insights:** Interpreted analytical outputs to identify operational improvement opportunities.
8. **Documentation:** Documented the database structure, SQL workflow, datasets, and analytical approach.

## 📸 Project Screenshots

### 1. Database Structure
<img width="317" height="361" alt="Database" src="https://github.com/user-attachments/assets/a51a3128-9f04-4f76-a8da-efd71d7fa89c" />  <img width="296" height="635" alt="Tables" src="https://github.com/user-attachments/assets/597a8887-d864-46f3-88b9-7b7f083c4ca1" />

### 2. Entity Relationship Diagram (ERD)



## 📁 Repository Structure

```text
Advanced-EdTech-Analytics-PostgreSQL/
│
├── data/
│   └── 18 CSV datasets
│
├── sql/
│   ├── 01_schema_postgresql.sql
│   ├── 02_advanced_analytics.sql
│   ├── 03_analytics_mart.sql
│   └── 04_import_with_psql.sql
│
├── results/
│   └── Selected SQL query outputs
│
├── screenshots/
│   └── Database, ERD and SQL screenshots
│
├── docs/
│   ├── Project_Workflow.md
│   ├── Business_Insights.md
│   └── Data_Dictionary.md
│
└── README.md
```

## 💡 Key Learning Outcomes

Through this project, I gained practical experience in:

- Designing and implementing relational databases using PostgreSQL.
- Writing advanced SQL queries using joins, CTEs, subqueries, aggregations, and window functions.
- Implementing primary keys, foreign keys, constraints, and indexes.
- Working with JSONB and semi-structured data.
- Creating analytical tables, refresh procedures, and materialized views.
- Performing data quality checks and validation.
- Analysing business performance across acquisition, learning, finance, and placement functions.
- Translating SQL outputs into meaningful business insights.

## 🚀 Future Scope

- Develop an interactive business intelligence dashboard.
- Extend student retention and cohort analysis.
- Explore automated data refresh and reporting workflows.
- Perform further SQL query optimisation and performance analysis.

## 👩‍💻 Project Information

**Project Domain:** Education Technology (EdTech)  
**Project Type:** End-to-End SQL Analytics  
**Database:** PostgreSQL  
**Data:** Synthetic portfolio dataset

---

⭐ If you find this project useful, feel free to explore the SQL scripts, datasets, and documentation.

**Thank you for visiting!**<img width="296" height="635" alt="Tables" src="https://github.com/user-attachments/assets/4edfe837-6ffb-4ba2-b104-a0c6460ed3bc" />

