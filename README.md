# 🤖 AI-Powered Automated Claims Triage System

**A full-stack actuarial engineering pipeline that automates the "First Notice of Loss" (FNOL) process using Large Language Models (LLMs) and Dockerized infrastructure.**

![Project Architecture](https://img.shields.io/badge/Architecture-Event%20Driven-blue) ![Status](https://img.shields.io/badge/Status-Live-success)

## 📌 Business Problem
Manual claims triage is slow and inconsistent. Actuaries and adjusters spend hours reading unstructured descriptions to estimate initial reserves. This latency leads to:
* **Stale Data:** Reserve estimates lag behind actual risk exposure.
* **Operational Bottlenecks:** High-severity claims get stuck in the same queue as minor scratches.

## 🚀 The Solution
I built an end-to-end automated pipeline that:
1.  **Ingests** raw claim emails instantly via Webhooks.
2.  **Analyzes** text using **GPT-4** to assign an Actuarial Severity Score (1-10) and calculate a recommended reserve.
3.  **Warehouses** structured data in a **PostgreSQL** database.
4.  **Visualizes** risk exposure in real-time using **R Shiny**.

## 🛠 Tech Stack
* **Orchestration:** n8n (Workflow Automation)
* **AI/ML:** OpenAI GPT-4o-mini (Natural Language Processing)
* **Database:** PostgreSQL (Dockerized)
* **Visualization:** R Shiny (Reactive Dashboarding)
* **Infrastructure:** Docker & Docker Compose

## 🏗 Architecture
**Data Flow:**
`Python Script (Simulation)` ➡️ `n8n Webhook` ➡️ `OpenAI (Logic Layer)` ➡️ `PostgreSQL (Storage)` ➡️ `R Shiny (Analytics)`

## 💻 How to Run This Project
**Prerequisites:** Docker Desktop installed.

1. **Clone the Repo:**
   ```bash
   git clone [https://github.com/ewetseklc/automated-claims-adjuster.git](https://github.com/ewetseklc/automated-claims-adjuster.git)