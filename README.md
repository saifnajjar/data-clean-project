# 🧹 Layoffs Data Cleaning Project (SQL)

## 📄 Project Overview
This project focuses on cleaning and standardizing a **layoffs dataset** using **MySQL**.  
The goal is to prepare a clean, well-structured dataset ready for analysis or visualization in **Power BI**, **Tableau**, or other data tools.

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




2️⃣ Detect and remove duplicates
CREATE TABLE layoffs_stage2 AS
SELECT *,
  ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off,
                 percentage_laid_off, date, stage, country, funds_raised_millions
  ) AS row_num
FROM layoffs_stage;

DELETE FROM layoffs_stage2
WHERE row_num > 1;




3️⃣ Trim and clean text columns

UPDATE layoffs_stage2
SET company = TRIM(company);


4️⃣ Normalize industry and country values

UPDATE layoffs_stage2
SET industry = 'crypto'
WHERE industry LIKE 'crypto%';

UPDATE layoffs_stage2
SET country = 'United States'
WHERE country LIKE 'United States%';


5️⃣ Convert date column to DATE type

ALTER TABLE layoffs_stage2 MODIFY COLUMN date DATE;
UPDATE layoffs_stage2
SET date = STR_TO_DATE(date, '%m/%d/%Y');


6️⃣ Handle missing industry values
UPDATE layoffs_stage2 t1
JOIN layoffs_stage2 t2
  ON t1.company = t2.company
 AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;


7️⃣ Delete records with no layoff data
DELETE FROM layoffs_stage2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;


8️⃣ Drop temporary column
ALTER TABLE layoffs_stage2 DROP COLUMN row_num;



