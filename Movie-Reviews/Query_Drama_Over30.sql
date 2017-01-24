--All drama movies and ratings from ppl > 30
		
SELECT
	m.*, r.Rating
FROM
	Movie m
INNER JOIN
	Review r ON r.Movie = m.Id
INNER JOIN
	Person p ON p.Id = r.Person
WHERE
	m.Genre = 'Drama' AND p.Age > 30;