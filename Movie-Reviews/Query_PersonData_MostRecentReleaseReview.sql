/*Get * Person Data for the people who reviewed 
the most recently released movie*/

DECLARE @MovieId AS INT = 
	(SELECT TOP 1 Id FROM Movie 
	ORDER BY ReleaseDate DESC);

SELECT
	p.*
FROM
	Person p
INNER JOIN
	Review r ON r.Person = p.Id
INNER JOIN
	Movie m ON m.Id = r.Movie
WHERE
	m.ID = @MovieId;
