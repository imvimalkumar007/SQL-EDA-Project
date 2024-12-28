-- Exploratory Data Analysis --

SELECT * 
FROM 
	layoffs_staging2;

SELECT 
	MAX(total_laid_off), MAX(percentage_laid_off)
FROM 
	layoffs_staging2
WHERE 
	percentage_laid_off = 1;

SELECT 
	company, 
	SUM(total_laid_off) total_laidoff 
FROM 
	layoffs_staging2
GROUP BY 
	company
ORDER BY 
	2 DESC;
    
SELECT 
	country, 
	SUM(total_laid_off) 
FROM 
	layoffs_staging2
GROUP BY 
	country
ORDER BY 
	2 DESC;
    
SELECT 
	YEAR (`date`), 
	SUM(total_laid_off) 
FROM 
	layoffs_staging2
GROUP BY 
	YEAR (`date`)
ORDER BY 
	1 DESC;
    
SELECT 
	stage, 
	SUM(total_laid_off) 
FROM 
	layoffs_staging2
GROUP BY 
	stage
ORDER BY 
	2 DESC;
    
SELECT 
	stage, 
	SUM(total_laid_off) 
FROM 
	layoffs_staging2
GROUP BY 
	stage
ORDER BY 
	2 DESC;
    
-- Rolling Total of Lay Offs --

SELECT SUBSTRING(`date`, 1, 7) as MONTH, SUM(total_laid_off)
FROM
	layoffs_staging2
WHERE
	SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY 
	`MONTH`
ORDER BY 1 ASC;

WITH rolling_total AS
(SELECT 
	SUBSTRING(`date`, 1, 7) as `MONTH`, SUM(total_laid_off) as total_off
FROM 
	layoffs_staging2
WHERE
	SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY 
	`MONTH`
ORDER BY 1 ASC
)
SELECT
	`MONTH`, total_off, SUM(total_off) OVER(ORDER BY `MONTH`) as roll_total
FROM 
	rolling_total;
    
SELECT 
	company, SUM(total_laid_off)
FROM
	layoffs_staging2
GROUP BY
	company
ORDER BY 2 DESC;

SELECT 
	company, YEAR(`DATE`), SUM(total_laid_off)
FROM
	layoffs_staging2
GROUP BY
	company, YEAR(`DATE`)
ORDER BY 3 DESC;


WITH company_year as 
(
SELECT 
	company, YEAR(`DATE`) as years, SUM(total_laid_off) as total_laidoffs
FROM
	layoffs_staging2
GROUP BY
	company, YEAR(`DATE`)
), company_year_rank as 
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laidoffs DESC) as ranking
FROM 
	company_year
WHERE
	years IS NOT NULL
)
SELECT * 
FROM 
	company_year_rank
WHERE ranking <=5
;
