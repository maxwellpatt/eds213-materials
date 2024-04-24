.tables
SELECT Nest_ID, COUNT(*) FROM Bird_eggs
  GROUP BY Nest_ID;
.maxrows 8

SELECT Species FROM Bird_nests WHERE Site = 'nome';

SELECT Species, COUNT(*) AS Nest_count
  FROM Bird_nests
  WHERE Site = 'nome'
  GROUP BY Species
  ORDER BY Species
  LIMIT 2; --- processing of query generally proceeds in order of clauses
  
--- can nest queries
SELECT Scientific_name, Nest_count FROM 
  (
  SELECT Species, COUNT(*) AS Nest_count
  FROM Bird_nests
  WHERE Site = 'nome'
  GROUP BY Species
  ORDER BY Species
  LIMIT 2) JOIN Species ON Species = Code;
  
--- outer joins
CREATE TEMP TABLE a(cola INTEGER, common INTEGER);
INSERT INTO a VALUES (1,1), (2,2), (3,3);
SELECT * FROM  a;

CREATE TEMP TABLE b (common INTEGER, colb INTEGER);
INSERT INTO b VALUES (2,2), (3,3), (4,4), (5,5);
SELECT * FROM b;

--- inner join
SELECT * FROM a JOIN b USING (common);

--- left or right outer join
SELECT * FROM a LEFT JOIN b USING (common); --- everything in common, includes every from from a 
.nullvalue -NULL-

SELECT * FROM a RIGHT JOIN b USING (common);

--- What species do not have nest data?
SELECT * FROM Species 
  WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
  
--- Let's do the same using an outer join
SELECT Code, Scientific_name, Nest_ID, Species, Year
  FROM Species LEFT JOIN Bird_nests ON Code = Species
  WHERE Nest_ID IS NULL;
  
--- a gotcha when doing grouping
SELECT * FROM Bird_eggs LIMIT 3;
SELECT * FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
  WHERE Nest_ID = '14eabaage01';
  
SELECT Nest_ID, COUNT(*) 
  FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
  WHERE Nest_ID = '14eabaage01'
  GROUP BY Nest_ID;
  
--- but what about this?
SELECT Nest_ID, Species, COUNT(*)
  FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
  WHERE Nest_ID = '14eabaage01'
  GROUP BY Nest_ID;
  
--- workaround
SELECT Nest_ID, ANY_VALUE(Species), COUNT(*)
  FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
  WHERE Nest_ID = '14eabaage01'
  GROUP BY Nest_ID;
  
  
--- views
SELECT * FROM Camp_assignment;
SELECT Year, Site, Name, Stgart, "End",
  FROM Camp_assignment JOIN Personnel
  On Observer = Abbreviation;
CREATE VIEW v AS 
  SELECT Year, Site, Name, Start, "End",
  FROM Camp_assignment JOIN Personnel
  On Observer = Abbreviation;
  
--- a view looks just like a table, but its not real
SELECT * FROM v;
CREATE VIEW v2 AS SELECT COUNT(*) FROM Species;
SELECT * FROM v2;
  
--- set operations: UNION, INTERSECT, EXCEPT
--- iffy example
SELECT Book_page, Nest_ID, Egg_num, Length, Width FROM Bird_eggs;
SELECT Book_page, Nest_ID, Egg_num, Length*25.4, Width*25.4 FROM Bird_eggs
  WHERE Book_page = 'b14.6'
  UNION
SELECT Book_page, Nest_ID, Egg_num, Length, Width FROM Bird_eggs
  WHERE Book_page != 'b14.6';

--- UNION vs UNION ALL
--- just mashes tables together
--- Third way to answer: Which speices have no nest data?
SELECT Code FROM Species
  EXCEPT SELECT DISTINCT Species FROM Bird_nests;
  
  
  
  
  