 --- Monday typescripts ----------------
SELECT * FROM SPECIES;

--- limiting rows
SELECT * FROM Species LIMIT 5; 
SELECT * FROM Species LIMIT 5 OFFSET 5; --- skips first 5

--- How many rows?
SELECT COUNT(*) FROM SPECIES;

--- how many distinct values occur?
SELECT DISTINCT Species from Bird_nests;

--- Can select which columns to return by naming them
SELECT * FROM Species;
SELECT Code, Common_name FROM Species;
SELECT Species FROM Bird_nests;

--- Get distinct combinations
SELECT DISTINCT Species FROM Bird_nests;

--- Ordering of results
SELECT DISTINCT Species FROM Bird_nests ORDER BY Species;

--- Exercise: what distinct locations occurin the site table? Order them 
--- Also, limit to 3 results
SELECT DISTINCT Location FROM Site ORDER BY Location LIMIT 3;  



 --- Wednesday typescripts ----------------
 .maxrow 6
 SELELCT Location FROM Site;
 SELECT * FROM Site WHERE Area < 200;
 SELECT * FROM SITE WHERE Area < 200 AND Location LIKE '%USA';
 
 --- expressions
SELECT Site_name, Area FROM Site;
SELECT Site_name, Area*2.47 FROM Site;
SELECT Site_name, Area*2.47 AS Area_acres FROM Site;
SELECT Site_name || 'foo' FROM Site;
SEELCT COUNT(*) AS num_rows FROM Site;
.help mode
.mode box
SELECT Site_name, Area*2.47 AS Area_acres FROM Site
SELECT COUNT(Scientific_name) FROM Species;
SELECT DISTINCT Relevance FROM Species
SELECT COUNT(DISTINCT Relevance) FROM Species;

--- MIN, MAX, AVG
SELECT AVG(Area) FROM Site;

--- grouping
SELECT * FROM Site;
SELECT Location, MAX(Area)
FROM SITE
GROUP BY Location;

SELECT * FROM Species;

Select Relevance, COUNT(*)
  FROM Species
  GROUP BY Relevance;
  
Select Relevance, COUNT(Scientific_name)
  FROM Species
  GROUP BY Relevance;
  
-- adding WHERE clause
SELECT Location, MAX(Area)
  FROM Site
  GROUP BY Location;
  
SELECT Location, MAX(Area)
  GROUP BY Location;
  
SELECT Location, MAX(Area)
  FROM Site
  WHERE Location LIKE '%Canada'
  GROUP BY Location;
  
SELECT Location, MAX(Area) AS Max_area
  FROM Site
  WHERE Location LIKE '%Canada'
  GROUP BY Location
  HAVING Max_area > 200;
  
--- relational algebra peeks through
SELECT COUNT(*) FROM Site; --- this is a table!
SELECT COUNT(*) FROM (SELECT COUNT(*) FROM Site); --- there is 1 row in the table above

SELECT * FROM Bird_nests LIMIT 3;
SELECT COUNT(*) FROM Species;
SELECT * FROM Species 
  WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
  
--- saving queries
CREATE TEMP TABLE t AS 
  SELECT * FROM Species 
  WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
  
  
-- or pernmanently
CREATE TEMP TABLE t_perm AS 
  SELECT * FROM Species 
  WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
  
SELECT * FROM t_perm;

DROP TABLE t_perm;

--- NULL processing
SELECT COUNT(*) FROM Bird_nests
  WHERE floatAge > 5;
SELECT COUNT(*) FROM Bird_nests
  WHERE floatAge <= 5;
  
SELECT COUNT(*) FROM Bird_nests WHERE floatAge IS NULL; -- count NULL values

--- joins
SELECT * FROM Camp_assignment;
SELECT * FROM Personnel;
SELECT * FROM Camp_assignment JOIN Personnel
  ON Observer = Abbreviation;
.mode csv
SELECT * FROM Camp_assignment JOIN Personnel
  ON Observer = Abbreviation
  LIMIT 3;
.mode csv
.mode duckdbox

SELECT * FROM Camp_assignment JOIN Personnel
  ON Camp_assignment.Observer = Personnel.Abbreviation;
  
SELECT * FROM Camp_assignment AS ca JOIN Personnel AS p
  ON ca.Observer = p.Abbreviation;
  
  --- multiway join
SELECT * FROM Camp_assignment ca JOIN Personnel p
  ON ca.Observer = p.Abbreviation
  JOIN Site s
  ON ca.Site = s.Code
  WHERE ca.Observer = 'lmckinnon'
  LIMIT 3;
  
--- order by: at the end 
SELECT * FROM Camp_assignment ca JOIN (
  SELECT * FROM Personnel ORDER BY Abbreviation
  ) p
  ON ca.Observer = p.Abbreviation
  JOIN SITE s
  ON ca.Site = s.Code
  WHERE ca.Observer = 'lmckinnon'
  LIMIT 3;

