---- week5
SELECT * FROM Species;
.maxrows 8
INSERT INTO Species VALUES ('abcd', 'thing', 'scientific name', NULL)

SELECT * FROM Species

--- You can explicitly label the columns 
INSERT INTO Species (Common_name, Scientific_name, Code, Relevance)
  VALUES ('thing2', 'another scientific name', 'efgh', NULL);
  
--- Take advantage of default values
INSERT INTO Species (Common_name, Code) VALUES ('thing 3', 'ijkl')

--- UPDATE and DELETE
UPDATE Species SET Relevance = 'not sure yet' WHERE Relevance IS NULL;
SELECT * FROM Species;
DELETE FROM Species WHERE Relevance = 'not sure yet';

--- Safe delete practice #1
SELECT * FROM Species WHERE Relevance = 'Study species';

--- Outputting data
COPY Snow_cover FROM 'snow_cover_fixedman_JB.csv' (header TRUE); -- csv manually altered

COPY Species TO 'species_fixed.csv'  (HEADER, DELIMITER ',');

--- Triggers!
