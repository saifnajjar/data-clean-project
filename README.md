🧹 Layoffs Data Cleaning Project (SQL)
📄 Project Overview

This project focuses on cleaning and standardizing a layoffs dataset using MySQL.
The goal is to prepare a clean, well-structured dataset ready for analysis or visualization (in BI tools like Power BI or Tableau).

🧠 Objectives

Remove duplicate records

Standardize text fields (company, industry, country, etc.)

Convert date strings to proper DATE format

Handle missing and null values

Drop unnecessary or invalid records

🏗️ Project Workflow

Create a staging table

CREATE TABLE layoffs_stage LIKE layoffs;
INSERT INTO layoffs_stage SELECT * FROM layoffs;


Detect and remove duplicates using ROW_NUMBER():

WITH duplicates_cte AS (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY company, location, industry, total_laid_off,
                   percentage_laid_off, date, stage, country, funds_raised_millions
    ) AS row_num
  FROM layoffs_stage
)
DELETE FROM layoffs_stage2 WHERE row_num > 1;


Trim and clean text columns

UPDATE layoffs_stage2
SET company = TRIM(company);


Normalize industry and country values

UPDATE layoffs_stage2
SET industry = 'crypto'
WHERE industry LIKE 'crypto%';

UPDATE layoffs_stage2
SET country = 'United States'
WHERE country LIKE 'United States%';


Convert date column to DATE type

ALTER TABLE layoffs_stage2 MODIFY COLUMN date DATE;
UPDATE layoffs_stage2 SET date = STR_TO_DATE(date, '%m/%d/%Y');


Handle missing industries

UPDATE layoffs_stage2 t1
JOIN layoffs_stage2 t2
  ON t1.company = t2.company
 AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;


Delete rows with no layoff data

DELETE FROM layoffs_stage2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

🧾 Final Output

The cleaned and standardized dataset is stored in layoffs_stage2, ready for further analysis or visualization.

Column	Description
company	Company name (trimmed and standardized)
location	Location of the layoff
industry	Industry name (normalized)
total_laid_off	Number of employees laid off
percentage_laid_off	Percentage of layoffs
date	Converted to DATE type
stage	Company stage (Startup, Series A, etc.)
country	Standardized country name
funds_raised_millions	Total funds raised (in millions)
⚙️ Tools Used

MySQL 8.0+

SQL Window Functions

Data Cleaning & ETL Techniques

📊 Use Case

This cleaned dataset can be used for:

Data visualization (Power BI, Tableau)

Exploratory data analysis

Trend analysis in layoffs by industry or country

🧑‍💻 Author

Saif Al-Din Al-Najjar — Software Engineer & Data Analyst
Skills: Python, Django, Flutter, SQL, Tableau, Power BI, Pandas
