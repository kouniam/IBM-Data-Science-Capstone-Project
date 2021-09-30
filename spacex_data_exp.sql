-- Shows the table (yay) 
SELECT * 
FROM SPACEXTBL


-- Task 1 : Display the names of the unique launch sites in the space mission
SELECT DISTINCT LAUNCH_SITE 
FROM SPACEXTBL


-- Task 2 : Display 5 records where launch sites begin with the string 'CCA'
SELECT * 
FROM SPACEXTBL
WHERE LAUNCH_SITE LIKE 'CCA%'
LIMIT 5


-- Task 3 : Display the total payload mass carried by boosters launched by NASA (CRS)
SELECT SUM(PAYLOAD_MASS__KG_) AS Total_Payload_NASA_CRS
FROM SPACEXTBL
WHERE CUSTOMER = 'NASA (CRS)'


-- Task 4 : Display average payload mass carried by booster version F9 v1.1
SELECT AVG(PAYLOAD_MASS__KG_) AS Average_Payload_F9_v11
FROM SPACEXTBL
WHERE BOOSTER_VERSION = 'F9 v1.1'


-- Task 5 : List the date when the first successful landing outcome in ground pad was acheived.
SELECT DATE
FROM SPACEXTBL
WHERE LANDING__OUTCOME LIKE '%ground pad%' 
	AND MISSION_OUTCOME = 'Success'
ORDER BY DATE ASC
LIMIT 1

-- alternatively, with MIN function
SELECT MIN(DATE)
FROM SPACEXTBL
WHERE LANDING__OUTCOME LIKE '%ground pad%' 
	AND MISSION_OUTCOME = 'Success'


-- Task 6 :  List the names of the boosters which have success in drone ship and have payload mass greater than 4000 but less than 6000
SELECT BOOSTER_VERSION
FROM SPACEXTBL
WHERE LANDING__OUTCOME LIKE '%drone ship%' 
	AND MISSION_OUTCOME = 'Success' 
	AND PAYLOAD_MASS__KG_ BETWEEN 4000 AND 6000


-- Task 7 : List the total number of successful and failure mission outcomes
SELECT MISSION_OUTCOME, COUNT(MISSION_OUTCOME) AS TOTAL
FROM SPACEXTBL
GROUP BY MISSION_OUTCOME


-- Task 8 : List the names of the booster_versions which have carried the maximum payload mass. Use a subquery
SELECT BOOSTER_VERSION
FROM SPACEXTBL
WHERE (SELECT MAX(PAYLOAD_MASS__KG_) FROM SPACEXTBL) = PAYLOAD_MASS__KG_


-- Task 9 : List the failed landing_outcomes in drone ship, their booster versions, and launch site names for in year 2015
SELECT BOOSTER_VERSION, LAUNCH_SITE
FROM SPACEXTBL
WHERE LANDING__OUTCOME = 'Failure (drone ship)' 
	AND DATE LIKE '%2015%'
	
	
-- Task 10 : Rank the count of landing outcomes (such as Failure (drone ship) or Success (ground pad)) between the date 2010-06-04 and 2017-03-20, in descending order
SELECT LANDING__OUTCOME, COUNT(LANDING__OUTCOME) AS TOTAL
FROM SPACEXTBL
WHERE DATE BETWEEN '2010-06-04' AND '2017-03-20'
GROUP BY LANDING__OUTCOME
ORDER BY TOTAL DESC
