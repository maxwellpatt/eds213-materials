--- Monday typescripts 
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