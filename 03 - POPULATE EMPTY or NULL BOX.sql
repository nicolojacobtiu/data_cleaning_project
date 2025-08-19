-- 3. Populating NULLS values and Empty boxes

SELECT DISTINCT industry
FROM layoffs_staging_02;

-- --------------------------------------------------------------------------------
-- Airbnb has empty so need to manually check the airBNB to see if there are industry rows in the airbnb has data
-- Bally's Interactive has NULL 
-- Carvana has empty box
-- Juul has empty box

SELECT *
FROM layoffs_staging_02
WHERE industry IS NULL 
OR industry = '';

-- --------------------------------------------------------------------------------
-- the airbnb has 2 rows, 1 is empty and another says 'Travel'
SELECT *
FROM layoffs_staging_02
WHERE company = 'Airbnb'
OR company = 'Juul'
OR company = 'Carvana'
OR company = 'Bally''s Interactive';


-- same as above but much cleaner syntax
SELECT *
FROM layoffs_staging_02
WHERE company IN ( 'Airbnb', 'Juul', 'Carvana', 'Bally''s Interactive');


-- i want to populate the empty boxes and since some duplicates have input, I just want to copy them
-- i will use the JOIN function by joining two tables by itself. 
-- combine industry + company
-- 
SELECT ST1.industry, ST2.industry
FROM layoffs_staging_02 ST1 -- table 1
JOIN layoffs_staging_02 ST2 -- table 2
	ON ST1.company = ST2.company

WHERE (ST1.industry IS NULL OR ST1.industry = '')
AND ST2.industry IS NOT NULL;

-- using [SELECT ST1.industry, ST2.industry], was able to see 2 tables
-- now to use UPDATE - SET statement

UPDATE layoffs_staging_02 ST1
			JOIN layoffs_staging_02 ST2
				ON ST1.company = ST2.company
SET ST1.industry = ST2.industry
WHERE ST1.industry IS NULL;

-- Recheck -> doesnt work
-- plan is to set the ST1.industry -> NULLS (all of them)
-- use UPDATE - SET function, to change blanks to NULLS

UPDATE layoffs_staging_02
SET industry = NULL
WHERE industry = '';

-- Recheck again

SELECT ST1.industry, ST2.industry
FROM layoffs_staging_02 ST1
JOIN layoffs_staging_02 ST2
	ON ST1.company = ST2.company

WHERE (ST1.industry IS NULL OR ST1.industry = '')
AND ST2.industry IS NOT NULL;

-- time to edit the where clause since the table doesnt have blank
-- removed this => OR ST1.industry = '')


UPDATE layoffs_staging_02 ST1
			JOIN layoffs_staging_02 ST2
				ON ST1.company = ST2.company
SET ST1.industry = ST2.industry
WHERE ST1.industry IS NULL 
AND ST2.industry IS NOT NULL;

-- recheck the update
-- -> works properly but Bally Interactiev still has NULL
SELECT *
FROM layoffs_staging_02
WHERE company IN ( 'Airbnb', 'Juul', 'Carvana', 'Bally''s Interactive');

-- check Bally's Interactive
-- -> it only has 1 row and doesnt have a populated row so why it didnt populate. 
SELECT *
FROM layoffs_staging_02
WHERE company LIKE 'Bally''s Interactive'; 








-- -----------------------------------------------------
-- conclusion
-- change empty boxes with NULLS via UPDATE - SET
-- 










