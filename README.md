# SQL Project: Layoff Data Analysis #2

This project is a continuation of a previous data cleaning project, focusing on conducting **Exploratory Data Analysis (EDA)** on a dataset of layoffs. Using SQL, this analysis extracts insights from the data, such as total layoffs by company, country, and year, as well as trends and patterns in layoff activity.

## Project Overview

The analysis builds on a cleaned dataset (`layoffs_staging2`) and includes SQL queries for:
1. Identifying maximum layoffs and percentages.
2. Summarizing layoffs by:
   - Company
   - Country
   - Year
   - Business stage
3. Calculating rolling totals of layoffs over time.
4. Ranking top companies with the highest layoffs each year.

The project demonstrates practical SQL techniques such as:
- Aggregations (`SUM`, `MAX`)
- Date functions (`YEAR`, `SUBSTRING`)
- Window functions (`SUM() OVER`, `DENSE_RANK()`)

## Key Queries
Some of the core SQL operations include:
- Total layoffs grouped by company and year:
  ```sql
  SELECT 
      company, YEAR(`DATE`), SUM(total_laid_off)
  FROM
      layoffs_staging2
  GROUP BY
      company, YEAR(`DATE`)
  ORDER BY 3 DESC;
