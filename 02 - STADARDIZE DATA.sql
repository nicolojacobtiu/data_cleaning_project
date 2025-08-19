-- --------------------------------------------------------------------------------


-- 2. STANDARDIZING DATA

-- --------------------------------------------------------------------------------

SELECT *
FROM layoffs_staging_02;
-- --------------------------------------------------------------------------------
-- company column has spaces before the data. need to remove them by using DISTINCT function

SELECT DISTINCT (company)
FROM layoffs_staging_02
;
-- --------------------------------------------------------------------------------
-- E Inc. and Included Health have spaces before. So TRIM funtion is appropriate for this

SELECT company, (TRIM(company))
FROM layoffs_staging_02
;

-- use update function with SET
UPDATE layoffs_staging_02
SET company = (TRIM(company))
;

-- recheck the company column and the spaces are now removed. 
SELECT company
FROM layoffs_staging_02
;

-- --------------------------------------------------------------------------------
-- theres duplicates so need to use DISTINCT func
SELECT industry
FROM layoffs_staging_02;

-- --------------------------------------------------------------------------------
-- Crypto, Crypto Currency and CryptoCurrency needs update -> Cryptocurrency
SELECT DISTINCT industry
FROM layoffs_staging_02
ORDER BY 1;

-- Use where filter -> 
SELECT  *
FROM layoffs_staging_02
WHERE industry LIKE 'Crypto%';


-- use update function with SET 
-- now all are Cryptocurrency

UPDATE layoffs_staging_02
SET industry = 'Cryptocurrency'
WHERE industry LIKE 'Crypto%'
;

-- double check with DISTINCT function

SELECT DISTINCT industry
FROM layoffs_staging_02;


-- check country column and United State has a dot

SELECT DISTINCT country
FROM layoffs_staging_02
ORDER by 1;

-- Use TRIM + TRAILING FROM to remove the dot

SELECT DISTINCT country, TRIM(TRAILING '.' from country)
FROM layoffs_staging_02
ORDER BY 1;

-- then use update set

UPDATE layoffs_staging_02
SET country = TRIM(TRAILING '.' from country)
WHERE country LIKE 'United States%';

-- recheck country column again
-- the dot from the united state now removed

SELECT DISTINCT country
FROM layoffs_staging_02
ORDER BY 1;

-- standarizing the date column.. 
-- the date column is not the standard
SELECT `date`
FROM layoffs_staging_02;

-- need to change the text to DATE STRING using STR_TO_DATE()
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y') 
FROM layoffs_staging_02;

-- use the update function
UPDATE layoffs_staging_02
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y') 
;

-- double check the result and its updated

SELECT `date`
FROM layoffs_staging_02;

-- chage date column to date format

ALTER TABLE layoffs_staging_02
MODIFY COLUMN `date` DATE;

-- refreshed and the date column is now set to date 




-- SUMMARY
-- 1. removed the spaces before the date | TRIM 
-- 2. changed the name crypto% to Cryptocurrency | SET & =
-- 3. remove the dot from United States | TRIM + TRAILING FROM
-- 4. time series | use STR_TO_DATE('xxxx', '%m/%d/%Y') -- Y should always be capital
-- 5. change the date column from text format -> date format | use ALTER TABLE > MODIFY COLUMN DATE