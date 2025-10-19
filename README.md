# 🧹 Layoffs Data Cleaning Project (SQL)

## 📄 Project Overview
This project focuses on cleaning and standardizing a **layoffs dataset** using **MySQL**.  
The goal is to prepare a clean, well-structured dataset ready for analysis or visualization (in BI tools like **Power BI** or **Tableau**).

---

## 🧠 Objectives
- 🗑️ Remove duplicate records  
- 🧾 Standardize text fields (company, industry, country, etc.)  
- 🗓️ Convert date strings to proper `DATE` format  
- 🧩 Handle missing and null values  
- 🚫 Drop unnecessary or invalid records  

---

## 🏗️ Project Workflow

### 1️⃣ Create a staging table
```sql
CREATE TABLE layoffs_stage LIKE layoffs;
INSERT INTO layoffs_stage SELECT * FROM layoffs;
