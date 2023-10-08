create schema zomatoproj;

#The Zomato Dataset was imported to the schema by using import Table wizard feature of MySQL

use zomatoproj;
select * from zomato_dataset; 
show tables;
select * from country_code;

#CHECKING FOR DUPLICATE
SELECT RestaurantID,COUNT(RestaurantID) FROM zomato_dataset
GROUP BY RestaurantID
ORDER BY 2 DESC; 

#REMOVING UNWANTED DATA
DELETE FROM zomato_dataset 
WHERE CountryCode IN (' Bar',' Grill',' Bakers & More"',' Chowringhee Lane"',' Grill & Bar"',' Chinese');


ALTER TABLE zomato_dataset DROP COLUMN Address;
ALTER TABLE zomato_dataset DROP COLUMN LocalityVerbose ;


#CREATING A COUNTRY NAME COLUMN BY JOINING TWO TABLES
SELECT zomato_dataset.CountryCode,country_code.COUNTRY
FROM zomato_dataset JOIN country_code
ON zomato_dataset.CountryCode = country_code.CountryCode;

ALTER TABLE zomato_dataset ADD COUNTRY_NAME VARCHAR(50);

UPDATE zomato_dataset
join country_code on zomato_dataset.CountryCode = country_code.CountryCode					 
SET zomato_dataset.COUNTRY_NAME = country_code.Country;

#CORRECTING MISPELT CITIES
SELECT DISTINCT City FROM zomato_dataset 
WHERE CITY LIKE '%?%';													  

SELECT REPLACE(CITY,'?','i') 
FROM zomato_dataset WHERE CITY LIKE '%?%';	

SELECT REPLACE(CITY,'?','I') 
FROM zomato_dataset WHERE CITY LIKE '?stanbul';
									 
UPDATE zomato_dataset 
SET City  = REPLACE(CITY,'?','i') 
WHERE CITY LIKE '%?%';	 	

UPDATE zomato_dataset 
SET City  = REPLACE(CITY,'?','I') 
WHERE CITY LIKE '?stanbul';	

#COUNTING TOTAL RESTASTAURANTS IN EACH COUNTRY
SELECT COUNTRY_NAME, COUNT(COUNTRY_NAME) FROM zomato_dataset
GROUP BY COUNTRY_NAME
ORDER BY 2 DESC;
		 
#COUNTING TOTAL RESTASTAURANTS. IN EACH CITY OF PARTICULAR COUNTRY
SELECT COUNTRY_NAME, CITY, COUNT(City) AS TOTAL_RESTAUTAURANTS							      
FROM zomato_dataset
GROUP BY COUNTRY_NAME,CITY 
ORDER BY 1,2,3 DESC;

# LOCATIONS OF VARIOUS RESTAURANTS IN INDIA
SELECT CITY,Locality, COUNT(Locality) as COUNT_LOCALITY,														
SUM(COUNT(Locality)) OVER(PARTITION BY City ORDER BY CITY,Locality) AS ROLL_COUNT
FROM zomato_dataset
WHERE COUNTRY_NAME = 'INDIA'
GROUP BY Locality,CITY
ORDER BY 1,2,3 DESC;

# DIFFERENT CUISINES AND THEIR COUNT
SELECT Cuisines,COUNT(Cuisines)
FROM zomato_dataset
GROUP BY Cuisines
ORDER BY 2 DESC;

# COUNTING DIFFERENT CURRENCIES
SELECT Currency, COUNT(Currency) FROM zomato_dataset
GROUP BY Currency
ORDER BY 2 DESC;

# CHECKING VARIOUS COLUMNS AND DROPPING UNNECESSARY COLUMNS
SELECT DISTINCT(Has_Table_booking) FROM zomato_dataset;
SELECT DISTINCT(Has_Online_delivery) FROM zomato_dataset;
SELECT DISTINCT(Is_delivering_now) FROM zomato_dataset;
SELECT DISTINCT(Switch_to_order_menu) FROM zomato_dataset;
SELECT DISTINCT(Price_range) FROM zomato_dataset;
ALTER TABLE zomato_dataset drop Switch_to_order_menu;

# MINIMUM, MAXIMUM AND AVERAGE VOTES   (OF A PARTICULAR RESTAURANT????)
SELECT MIN(Votes) as MIN_VOTE,AVG(Votes) as AVG_VOTE,MAX(Votes) as MAX_VOTE
FROM zomato_dataset;

# MINIMUM, MAXIMUM AND AVERAGE COST FOR TWO
SELECT Currency,MIN(Average_Cost_for_two) as MIN_COST,AVG(Average_Cost_for_two) as AVG_COST,MAX(Average_Cost_for_two) as MAX_COST
FROM zomato_dataset
GROUP BY Currency ;

#INSERTING RATINGS COLUMN
SELECT MIN(Rating),
ROUND(AVG(Rating),1), 
MAX(Rating)  
FROM zomato_dataset;


SELECT RestaurantName,RATING,CASE
WHEN Rating >= 1 AND Rating < 2.5 THEN 'POOR'
WHEN Rating >= 2.5 AND Rating < 3.5 THEN 'GOOD'
WHEN Rating >= 3.5 AND Rating < 4.5 THEN 'GREAT'
WHEN Rating >= 4.5 THEN 'EXCELLENT'
END RATE_CATEGORY
FROM zomato_dataset
GROUP BY RestaurantName,RATING
ORDER BY 2 DESC;

ALTER TABLE zomato_dataset ADD RATE_CATEGORY VARCHAR(20);
UPDATE zomato_dataset SET RATE_CATEGORY = (CASE								     
WHEN Rating >= 1 AND Rating < 2.5 THEN 'POOR'
WHEN Rating >= 2.5 AND Rating < 3.5 THEN 'GOOD'
WHEN Rating >= 3.5 AND Rating < 4.5 THEN 'GREAT'
WHEN Rating >= 4.5 THEN 'EXCELLENT'
END)















