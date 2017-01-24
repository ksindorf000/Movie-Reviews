--Occupation of people under 40
SELECT
	*
FROM 
	Person
WHERE
	Age < 40 
	AND Age IS NOT NULL;