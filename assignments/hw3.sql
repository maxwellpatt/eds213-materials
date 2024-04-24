--- Problem #1 ------------------------------
--- part one ------------------------------

-- Create a temporary table with a REAL column
CREATE TEMP TABLE mytable (
    val REAL
);

-- Insert some values, including NULL
INSERT INTO mytable (val) VALUES (1.0), (2.0), (NULL), (3.0), (4.0);

-- Calculate the average
SELECT AVG(val) FROM mytable;

The output value is 2.5, showing us that the NULl values are not considered 
when calculating the average of values.

--- part two ------------------------------

The correct query is the first one:
SELECT SUM(mycolumn) / COUNT(*) FROM mytable;

This query calculates the sum of all non-NULL values in the mycolumn column 
and divide the sum by the total number of rows, including those with NULL values. 
The result is the same as using the AVG function, which ignores NULL 
values when calculating the average. The second query will give an incorrect result 
because it treats NULL values as if they have a value of zero, which is not the 
behavior of the AVG function.


--- Problem #2 ------------------------------
--- part one ------------------------------
The query is invalid because SQL doesn't know which Site_name value to associate with 
the maximum Area. Aggregating functions like MAX expect to return a single row, 
but the problem is Site_name contains multiple values. To fix this, you need to use a subquery or 
JOIN to bridge the aggregated value with the corresponding non-aggregated values. 
The query combines an aggregated and non-aggregated column, which causes the error.

--- part two ------------------------------
SELECT Site_name, Area
FROM Site
ORDER BY Area DESC
LIMIT 1;

--- part three ------------------------------
SELECT Site_name, Area
FROM Site
WHERE Area = (
   SELECT MAX(Area)
   FROM Site
);


--- Problem #3 ------------------------------
--- 1. Create subquery (Nest_Avg_Volume) to calculate average egg volume per nest
--- a. Join Bird_eggs and Bird_nests on Nest_ID
--- b. Calculate average egg volume using formula
--- c. Group by Nest_ID

--- 2. Join Nest_Avg_Volume with Bird_nests and Species
--- a. Join Nest_Avg_Volume and Bird_nests on Nest_ID
--- b. Join Bird_nests and Species on Species column

--- 3. Filter results to include only study species

--- 4. Group results by Scientific_name from Species table

--- 5. Calculate maximum average volume for each species

--- 6. Select Scientific_name and maximum average volume

--- 7. Order results by maximum average volume in descending order


SELECT
    Species.Scientific_name,
    MAX(Nest_Avg_Volume.Avg_volume) AS Max_avg_volume
FROM (
    SELECT
        Bird_nests.Nest_ID,
        AVG((Bird_eggs.Width * Bird_eggs.Width * Bird_eggs.Length * 3.14) / 6) AS Avg_volume
    FROM Bird_eggs
    JOIN Bird_nests ON Bird_eggs.Nest_ID = Bird_nests.Nest_ID
    GROUP BY Bird_nests.Nest_ID
) AS Nest_Avg_Volume
JOIN Bird_nests ON Nest_Avg_Volume.Nest_ID = Bird_nests.Nest_ID
JOIN Species ON Bird_nests.Species = Species.Code
WHERE Species.Relevance = 'Study species'
GROUP BY Species.Scientific_name
ORDER BY MAX(Nest_Avg_Volume.Avg_volume) DESC;

