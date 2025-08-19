-- 4. DELETE columns by dropping

-- if total_laid_off and percentage_laid_off are both NULL, looks like the data cant be used

SELECT *
FROM layoffs_staging_02
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- its makes sense to delete these rows as both are NULL

DELETE
FROM layoffs_staging_02
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- RNUM or my created row number, is still in the table and there is no use for it
-- use ALTER TABLE - DROP
-- now RNUM is deleted

ALTER TABLE layoffs_staging_02
DROP COLUMN RNUM;





