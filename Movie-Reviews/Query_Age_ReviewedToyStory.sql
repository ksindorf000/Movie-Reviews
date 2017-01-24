--Age of each reviewer who reviewed Toy Story
SELECT
	p.Age
FROM
	Person p
INNER JOIN
	Review r ON r.Person = p.Id
WHERE
	r.Movie = 1;
