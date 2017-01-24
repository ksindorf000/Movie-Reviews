--All Movies with Ratings less than 2
SELECT
	m.Title, r.Rating
FROM
	Movie m
INNER JOIN
	Review r ON r.Movie = m.Id
WHERE
	r.Rating < 2;