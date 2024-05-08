--- Missing data
--- NOT IN
SELECT Code 
  FROM Site
  WHERE Code NOT IN (
    SELECT DISTINCT Site 
    FROM Bird_eggs
)
ORDER BY Code;

--- WHERE
SELECT s.Code
  FROM Site s
  LEFT JOIN Bird_eggs b ON s.Code = b.Site
  WHERE b.Site IS NULL
  ORDER BY s.Code;

--- EXCEPT
SELECT Code FROM Site
  EXCEPT SELECT DISTINCT Site
  FROM Bird_eggs
  ORDER BY Code;

--- Who worked with whom?
SELECT
    A.Site,
    A.Observer AS Observer_1,
    B.Observer AS Observer_2
  FROM Camp_assignment A
  JOIN Camp_assignment B
    ON A.Site = B.Site
    AND A.Start <= B.End
    AND B.Start <= A.End
    AND A.Observer < B.Observer
  WHERE A.Site = 'lkri'
  ORDER BY A.Site, A.Observer, B.Observer;

--- Bonus
SELECT
      A.Site,
      p1.Name AS Name_1,
      p2.Name AS Name_2
  FROM Camp_assignment A
  JOIN Camp_assignment B
      ON A.Site = B.Site
      AND A.Start <= B.End
      AND B.Start <= A.End
      AND A.Observer < B.Observer
  JOIN Personnel p1 ON A.Observer = p1.Abbreviation
  JOIN Personnel p2 ON B.Observer = p2.Abbreviation
  WHERE A.Site = 'lkri'
  ORDER BY A.Site, Name_1, Name_2;

--- Who's the culprit?
SELECT 
    p.Name,
    COUNT(DISTINCT n.Nest_ID) AS Num_floated_nests
FROM Bird_nests n
JOIN Personnel p ON n.Observer = p.Abbreviation
WHERE n.Site = 'nome'
    AND n.Year BETWEEN 1998 AND 2008
    AND n.ageMethod = 'float'
    AND p.Abbreviation = (
        SELECT Observer
        FROM Bird_nests
        WHERE Site = 'nome'
            AND Year BETWEEN 1998 AND 2008
            AND ageMethod = 'float'
        GROUP BY Observer
        HAVING COUNT(DISTINCT Nest_ID) = 36
    )
GROUP BY p.Name;


