# ZOMATO_ANALYSIS_PROJECT

Zomato Data Exploration and Analysis with MySQL

In an age where culinary experiences are just a click away, Zomato has emerged as a formidable platform, connecting millions of food enthusiasts with diverse dining options. With its vast repository of restaurant data, user reviews, and ratings, Zomato offers a treasure trove of information waiting to be explored and deciphered.

In this project, we embark on a gastronomic journey through the digital landscape of Zomato, aiming to uncover hidden insights, trends, and patterns in the world of dining. By delving into the extensive dataset provided by Zomato, we aim to answer intriguing questions:

- Regions with most listed restaurants?
- Are certain cuisines more popular in specific regions?
- Restaurants with Delivery Options?
- How does having a table booking facility affect ratings?

# DATA
The data is taken from Kaggle which is a dataset of Zomato Restaurants Data.

Data dimensions:
- Zomato (9552 Records)
- Zomato Country Code (15 Records)

# ANALYSIS

While Cleaning and Organising Data with SQL, I was working on the following things-
- Checked all the details of table such column name, data types and constraints
- Checked for duplicate values in [RestaurantId] column
- Removed unwanted columns from table
- Merged 2 differnt tables and added the new column of Country_Name with the help of primary key as [CountryCode] column
- Identitfied and corrected the mis-spelled city names
- Counted the no.of restaurants by rolling count/moving count using windows functions
- Checked min,max,avg data for votes, rating & currency column.
- Created new category column for rating
  

Then I proceeded with Analysing the Data where I found insights such as-
- According to this Zomato Dataset, 90.67% of data is related to restaurants listed in India followed by USA(4.45%).
- Out of 15 Countries only 2 countries provides Online delivery options to their customers, to be precised only 28.01% of restaurants in India and 46.67% of restaurants in 
  UAE provides online delivery options.

As this dataset contains data most related to India so i worked on gaining insights on Indian Restaurants.
- Connaught Place in New Delhi has the most listed restaurants (122) follwed by Rajouri Garden (99) and Shahdara (87)
- Most popular cuisines in Connaught Place is North Indian Food.
- Out of 122 restaurants in Connaught Place only 54 restaurants provide table booking facility to their customers.
- Average Ratings for restaurants with table booking facility is 3.9/5 compared to restaurants without table booking facility is 3.7/5 in Connaught Place,New Delhi.
- Best modrately priced restaurants with average cost for two < 1000, rating > 4, votes > 4 and provides both table booking and online delivery options to their customer 
  with indian cuisines is located in Kolkata,India named as 'India Restaurant',(RestaurantID - 20747).
