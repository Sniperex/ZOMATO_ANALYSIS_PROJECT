# ZOMATO_ANALYSIS_PROJECT

Zomato Data Exploration and Analysis with MySQL

In an age where culinary experiences are just a click away, Zomato has emerged as a formidable platform, connecting millions of food enthusiasts with diverse dining options. With its vast repository of restaurant data, user reviews, and ratings, Zomato offers a treasure trove of information waiting to be explored and deciphered.

In this project, we embark on a gastronomic journey through the digital landscape of Zomato, aiming to uncover hidden insights, trends, and patterns in the world of dining. By delving into the extensive dataset provided by Zomato, we aim to answer intriguing questions:

- What factors influence a restaurant's rating?
- Are certain cuisines more popular in specific regions?
- How do price ranges correlate with customer satisfaction?
- Can we identify emerging food trends from user reviews?

While Cleaning and Organising Data with SQL, I was working on the following things-

- Checked all the details of table such column name, data types and constraints
- Checked for duplicate values in [RestaurantId] column

3.Removed unwanted columns from table

4.Merged 2 differnt tables and added the new column of Country_Name with the help of primary key as [CountryCode] column

5.Identitfied and corrected the mis-spelled city names

6.Counted the no.of restaurants by rolling count/moving count using windows functions

7.Checked min,max,avg data for votes, rating & currency column.

8.Created new category column for rating


Then I proceeded with Analysing the Data where I found insights such as-

1.According to this Zomato Dataset, 90.67% of data is related to restaurants listed in India followed by USA(4.45%).

2.Out of 15 Countries only 2 countries provides Online delivery options to their customers, to be precised only 28.01% of restaurants in India and 46.67% of restaurants in 
  UAE provides online delivery options.

  
  
As this dataset contains data most related to India so i worked on gaining insights on Indian Restaurants.

1.Connaught Place in New Delhi has the most listed restaurants (122) follwed by Rajouri Garden (99) and Shahdara (87)

2.Most popular cuisines in Connaught Place is North Indian Food.

3.Out of 122 restaurants in Connaught Place only 54 restaurants provide table booking facility to their customers.

4.Average Ratings for restaurants with table booking facility is 3.9/5 compared to restaurants without table booking facility is 3.7/5 in Connaught Place,New Delhi.

5.Best modrately priced restaurants with average cost for two < 1000, rating > 4, votes > 4 and provides both table booking and online delivery options to their customer 
  with indian cuisines is located in Kolkata,India named as 'India Restaurant',(RestaurantID - 20747).
