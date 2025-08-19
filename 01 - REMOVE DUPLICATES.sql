-- --------------------------------------------------------------------------------
-- DATA CLEANING
-- created a new database


SELECT *
FROM layoffs_staging;

-- --------------------------------------------------------------------------------

-- 1. REMOVE DUPLICATES
-- 2. STANDARDIZE THE DATA
-- 3. NULL Values | BLACK VALUES
-- 4. DROP COLUMNS

-- --------------------------------------------------------------------------------
-- This creates a copy of the raw data or the untouched data. Just copies the table
-- never touch the raw data
CREATE TABLE layoffs_staging
LIKE layoffs;

-- This creates a copy of the rows of the raw data. 
INSERT layoffs_staging
SELECT *
FROM layoffs; 
-- Then recheck -> and its copied the data and table
SELECT *
FROM layoffs_staging;
-- --------------------------------------------------------------------------------
-- 1. Delete Duplicates

SELECT *, ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS RNUM
FROM layoffs_staging
-- WHERE RNUM > 1
;

-- CTE created to create a new column to see the number of row number greater than 1
WITH duplicate_CTE AS 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS RNUM
FROM layoffs_staging
)
SELECT *
FROM duplicate_CTE
WHERE RNUM > 1;

-- 5 rows shows duplicated, time to delete them but need to create another copied layoffs_stagin becuase of the CTE. 
-- right clicked layoff_staging -> COPY CLIPBOARD -> create statement -> then paste


CREATE TABLE `layoffs_staging_02` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `RNUM` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- I now have an empty table with RNUM or the row number.


SELECT *
FROM layoffs_staging_02
;

-- I have to manually insert again

INSERT INTO layoffs_staging_02
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS RNUM
FROM layoffs_staging
;

-- now I can filter

SELECT *
FROM layoffs_staging_02
WHERE RNUM > 1
;

-- now I can delete using the delete function

DELETE
FROM layoffs_staging_02
WHERE RNUM > 1
;

-- rechecked and rows with more than 1 are now deleted (5 rows)

SELECT *
FROM layoffs_staging_02
WHERE RNUM > 1
;

