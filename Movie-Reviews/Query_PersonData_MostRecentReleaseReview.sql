/*Get * Person Data for the people who reviewed 
the most recently released movie*/

SELECT
	TOP 1 p.*
FROM
	Person p
INNER JOIN
	Review r ON r.Person = p.Id
INNER JOIN
	Movie m ON m.Id = r.Movie
ORDER BY 
	m.ReleaseDate DESC;
