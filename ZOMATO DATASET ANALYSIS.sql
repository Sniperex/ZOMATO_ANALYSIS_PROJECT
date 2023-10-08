use zomatoproj;
select * from zomato_dataset;

# COUNT OF RESTAURANTS IN INDIAN CITIES
SELECT COUNTRY_NAME,City,Locality,COUNT(Locality) as TOTAL_RESTAURANTS,
SUM(COUNT(Locality)) OVER(PARTITION BY City ORDER BY Locality DESC)
FROM zomato_dataset
WHERE COUNTRY_NAME = 'INDIA'
GROUP BY  COUNTRY_NAME,City,Locality;


# PERCENTAGE OF RESTAURANTS IN ALL THE COUNTRIES
CREATE VIEW TOTAL_COUNT
AS
(
SELECT DISTINCT(COUNTRY_NAME),COUNT(RestaurantID) OVER() AS TOTAL_REST
FROM zomato_dataset
ORDER BY 1 DESC
);
drop VIEW TOTAL_COUNT;
SELECT * FROM TOTAL_COUNT;

CREATE VIEW CT1
AS
(
SELECT COUNTRY_NAME, COUNT(RestaurantID) AS REST_COUNT
FROM zomato_dataset
GROUP BY COUNTRY_NAME
);
SELECT * FROM CT1;
SELECT CT1.COUNTRY_NAME,CT1.REST_COUNT ,ROUND((CT1.REST_COUNT)/TOTAL_COUNT.TOTAL_REST*100,2) AS PERCENTAGE
FROM CT1 JOIN TOTAL_COUNT 
ON CT1.COUNTRY_NAME = TOTAL_COUNT.COUNTRY_NAME
ORDER BY 3 DESC;


# WHICH COUNTRIES AND HOW MANY RESTAURANTS WITH PERCENTAGE PROVIDES ONLINE DELIVERY OPTION
CREATE VIEW COUNTRY_REST
AS(
SELECT COUNTRY_NAME, COUNT(RestaurantID) AS REST_COUNT
FROM zomato_dataset
GROUP BY COUNTRY_NAME
);

SELECT * FROM COUNTRY_REST
ORDER BY 2 DESC;

SELECT zomato_dataset.COUNTRY_NAME,COUNT(zomato_dataset.RestaurantID) as TOTAL_REST, 
ROUND(COUNT(zomato_dataset.RestaurantID)/(COUNTRY_REST.REST_COUNT)*100, 2) AS PERCENTAGE
FROM zomato_dataset JOIN COUNTRY_REST
ON zomato_dataset.COUNTRY_NAME = COUNTRY_REST.COUNTRY_NAME
WHERE zomato_dataset.Has_Online_delivery = 'YES'
GROUP BY zomato_dataset.COUNTRY_NAME,COUNTRY_REST.REST_COUNT
ORDER BY 2 DESC;


# FINDING FROM WHICH CITY AND LOCALITY IN INDIA WHERE THE MAX RESTAURANTS ARE LISTED IN ZOMATO
WITH CT1
AS
(
SELECT City,Locality,COUNT(RestaurantID) AS REST_COUNT
FROM zomato_dataset
WHERE COUNTRY_NAME = 'INDIA'
GROUP BY CITY,LOCALITY
ORDER BY 3 DESC
)

SELECT Locality,REST_COUNT FROM CT1 WHERE REST_COUNT = (SELECT MAX(REST_COUNT) FROM CT1);


# TYPES OF FOODS ARE AVAILABLE IN INDIA WHERE THE MAX RESTAURANTS ARE LISTED IN ZOMATO
WITH CT1
AS
(
SELECT City,Locality,COUNT(RestaurantID) AS REST_COUNT
FROM zomato_dataset
WHERE COUNTRY_NAME = 'INDIA'
GROUP BY CITY,LOCALITY
ORDER BY 3 DESC
),
CT2 AS (
SELECT Locality,REST_COUNT FROM CT1 WHERE REST_COUNT = (SELECT MAX(REST_COUNT) FROM CT1)
),
CT3 AS (
SELECT DISTINCT Cuisines,Locality FROM zomato_dataset
)
SELECT  CT2.Locality, CT3.Cuisines
FROM CT2  JOIN CT3 
ON CT2.Locality = CT3.Locality
ORDER BY 2 ASC;


# WHICH LOCALITIES IN INDIA HAS THE LOWEST RESTAURANTS LISTED IN ZOMATO
WITH CT1 AS
(
SELECT City,Locality, COUNT(RestaurantID) AS REST_COUNT
FROM zomato_dataset
WHERE COUNTRY_NAME = 'INDIA'
GROUP BY City,Locality
ORDER BY 3 DESC
)
SELECT * FROM CT1 WHERE REST_COUNT = (SELECT MIN(REST_COUNT) FROM CT1) ORDER BY CITY;


# HOW MANY RESTAURANTS OFFER TABLE BOOKING OPTION IN INDIA WHERE THE MAX RESTAURANTS ARE LISTED IN ZOMATO
WITH CT1 AS (
SELECT City,Locality,COUNT(RestaurantID) AS REST_COUNT
FROM zomato_dataset
WHERE COUNTRY_NAME = 'INDIA'
GROUP BY CITY,LOCALITY
ORDER BY 3 DESC
),
CT2 AS (
SELECT Locality,REST_COUNT FROM CT1 WHERE REST_COUNT = (SELECT MAX(REST_COUNT) FROM CT1)
),
CT3 AS (
SELECT Locality,Has_Table_booking AS TABLE_BOOKING
FROM zomato_dataset
)
SELECT CT3.Locality, COUNT(CT3.TABLE_BOOKING) AS TABLE_BOOKING_OPTION
FROM CT3 JOIN CT2
ON CT3.Locality = CT2.Locality
WHERE CT3.TABLE_BOOKING = 'YES'
GROUP BY CT3.Locality;

# HOW RATING AFFECTS IN MAX LISTED RESTAURANTS WITH AND WITHOUT TABLE BOOKING OPTION (Connaught Place)
SELECT 'WITH_TABLE' TABLE_BOOKING_OPT,COUNT(Has_Table_booking) AS TOTAL_REST, ROUND(AVG(Rating),2) AS AVG_RATING
FROM zomato_dataset
WHERE Has_Table_booking = 'YES'
AND Locality = 'Connaught Place'
UNION
SELECT 'WITHOUT_TABLE' TABLE_BOOKING_OPT,COUNT(Has_Table_booking) AS TOTAL_REST, ROUND(AVG(Rating),2) AS AVG_RATING
FROM zomato_dataset
WHERE Has_Table_booking = 'NO'
AND Locality = 'Connaught Place';


# AVG RATING OF RESTS LOCATION WISE
SELECT COUNTRY_NAME,City,Locality,COUNT(RestaurantID) AS TOTAL_REST ,ROUND(AVG(Rating),2) AS AVG_RATING
FROM zomato_dataset
GROUP BY COUNTRY_NAME,City,Locality
ORDER BY 4 DESC;

# FINDING THE BEST RESTAURANTS WITH MODRATE COST FOR TWO IN INDIA HAVING INDIAN CUISINES
SELECT *
FROM zomato_dataset
WHERE COUNTRY_NAME = 'INDIA'
AND Has_Table_booking = 'YES'
AND Has_Online_delivery = 'YES'
AND Price_range <= 3
AND Votes > 1000
AND Average_Cost_for_two < 1000
AND Rating > 4
AND Cuisines LIKE '%INDIA%';

# FIND ALL THE RESTAURANTS THOSE WHO ARE OFFERING TABLE BOOKING OPTIONS WITH PRICE RANGE AND HAS HIGH RATING
SELECT Price_range, COUNT(Has_Table_booking) AS NO_OF_REST
FROM zomato_dataset
WHERE Rating >= 4.5
AND Has_Table_booking = 'YES'
GROUP BY Price_range;



# MOST POPULAR FOOD IN INDIA WHERE THE MAX RESTAURANTS ARE LISTED IN ZOMATO
CREATE VIEW VF 
AS
(
SELECT COUNTRY_NAME,City,Locality,Cuisines FROM zomato_dataset
);

WITH CT1
AS
(
SELECT City,Locality,COUNT(RestaurantID) AS REST_COUNT
FROM zomato_dataset
WHERE COUNTRY_NAME = 'INDIA'
GROUP BY CITY,LOCALITY
ORDER BY 3 DESC
),
CT2 AS (
SELECT Locality,REST_COUNT FROM CT1 WHERE REST_COUNT = (SELECT MAX(REST_COUNT) FROM CT1)
)
SELECT VF.Cuisines, COUNT(VF.Cuisines)
FROM VF JOIN CT2 
ON VF.Locality = CT2.Locality
GROUP BY CT2.Locality,VF.Cuisines
ORDER BY 2 DESC;



