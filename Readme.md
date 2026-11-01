# 🎓 Scholarship Eligibility & Application Tracker

A comprehensive, modular **Scholarship Tracker Application** developed in **Python** to streamline the process of finding, verifying, and monitoring student scholarship statuses. The application integrates a relational database engine to check real-time academic eligibility parameters, track application deadlines, and monitor verification lifecycles.

---

## 🎓 Project Details
- **Project Name:** Centralized Scholarship Tracker and Verification System
- **Student Developer:** Yashik Jindal
- **Role & Configuration:** Full-Stack Architecture & Relational Schema Design
- **Architecture Paradigm:** Relational Database-Driven Educational Utility Portal

---

## 🎯 Project Objectives
- **Centralize Information:** Move scattered scholarship deadlines and metrics into a unified relational database.
- **Automate Eligibility Auditing:** Implement automated rules to match student biometrics (GPA, Income, Category) with scholarship criteria.
- **Track Lifecycles:** Provide real-time monitoring of processing phases (e.g., 'Applied', 'Under Verification', 'Disbursed').
- **Eliminate Compliance Risks:** Introduce system safeguards to ensure students cannot double-claim mutually exclusive funds.

---

## ✨ Features
- **🔒 Secure User Dashboard:** Access control system ensuring safe entry vectors for students and verified evaluators.
- **📋 Live Eligibility Engine:** Programmatic checks that match user academic profiles with real-time scholarship requirements.
- **📅 Dynamic Timeline Tracker:** Active calendar interface showing closing milestones and automatic overdue alert metrics.
- **⚡ Database Constraint Triggers:** Relational layer protections that prevent duplicate submission anomalies.
- **📊 Application Lifecycle Updates:** Visual state indicators tracking current stages from initial submission to final bank disbursement.

---

## 🛠️ Project Component Structure

| Component File | Operational Purpose |
| :--- | :--- |
| **`app.py`** | The main execution engine managing system routing, middleware processes, and user views. |
| **`database.py`** | Defines structural DDL models, establishes runtime execution channels, and maps relational parameters. |
| **`scholarship.db`** | The native SQLite database instance storing student records, criteria tables, and active logs. |
| **`templates/`** | UI views directory housing presentation layer templates (Dashboard, Eligibility forms, Status logs). |

---

## 🗄️ Database Schema Outline

### 1. `student_profiles` (Academic Credentials)
- `student_id` (INTEGER) - Primary Key tracking unique student identifiers.
- `gpa_score` (REAL) - Performance index used for validation checks.
- `annual_income` (REAL) - Financial metric analyzed for socioeconomic eligibility.

### 2. `scholarship_schemes` (Criteria Constraints)
- `scheme_id` (TEXT) - Primary reference tracking operational funds.
- `min_gpa_required` (REAL) - Academic ceiling metric required for application access.
- `max_income_allowed` (REAL) - Economic cap validation limit.
- `closing_date` (TEXT) - Deadlines evaluated by scheduling engines.

### 3. `scholarship_applications` (Transaction Logs)
- `application_id` (INTEGER) - Auto-incrementing primary identity reference key.
- `student_id` (INTEGER) - Foreign Key mapping row connection back to student profile.
- `scheme_id` (TEXT) - Foreign Key mapping target scholarship nodes.
- `status` (TEXT) - Processing conditional toggle (`APPLIED` / `UNDER_VERIFICATION` / `DISBURSED`).

---

## 🚀 Local Installation & Deployment

1. **Clone the Repo:** Extract these repository source components onto your workstation.
2. **Launch Application Directory:** Open Command Prompt (CMD) in the root layout containing `app.py`.
3. **Install Framework Dependencies:** Set up application backend router components:
   ```bash
   pip install flask
   ```
4. **Deploy Local Server Instance:** Run the primary python executable script:
   ```bash
   python app.py
   ```
5. **Explore Portal Dashboard:** Open your preferred browser interface and navigate to:
   👉 `http://127.0.0`

---
*Developed for academic innovation assessment, modular database systems configuration, and educational full-stack logic paradigms.*
