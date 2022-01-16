/* 
This problem is found on hackerrank.com. Assuming that there is a table called 'STATION' with 'LAT_N' as one of its numerical columns. To find the median value with 4 decimal places from LAT_N, 
we need to write the following SQL quries:
*/

/*
**First, we need to create a separate index for the values we want to find the median, starting from 0 with the following query:
SET @rowindex := -1;

Then, we need to SELECT both the index value and the values from the LAT_N column, ordered by the values from LAT_N column in ascending order with the following query:

SELECT @rowindex := @rowindex + 1 AS rowindex,
        STATION.LAT_N AS LAT_N
    FROM STATION
    ORDER BY STATION.LAT_N) AS N

**We set the alias of the above SELECT query as 'N'. This will be our 'inner query'.
**Then we need to write an 'outer' query as the following:

SELECT ROUND(AVG(N.LAT_N),4)
FROM
 (**INNER QUERIES**)
 WHERE
 N.rowindex IN (FLOOR(@rowindex/2), CEIL(@rowindex/2));
 
**The use of IN((FLOOR(*), CEIL(*)) ensures that we will find the median wether the numbers of entries in the LAT_N column is odd or even.
**The complete queries for finding the median from a numerical column in MySQL (according to the above scenario) is as the following:
*/

SELECT ROUND(AVG(N.LAT_N),4)
FROM
(SELECT @rowindex := @rowindex + 1 AS rowindex,
        STATION.LAT_N AS LAT_N
    FROM STATION
    ORDER BY STATION.LAT_N) AS N
WHERE
N.rowindex IN (FLOOR(@rowindex/2), CEIL(@rowindex/2));