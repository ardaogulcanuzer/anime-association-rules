# Anime Preference Analysis with Association Rules

This project explores user preferences in anime using **association rule mining**.

The goal is to identify patterns in how anime titles are liked together by users.

## Dataset

The analysis is based on anime rating data where:

- Each **user represents a transaction**
- Highly rated anime titles (**rating ≥ 8**) represent **items**
- The study focuses on the **Top 200 most popular anime titles**

## Methodology

The workflow includes:

1. Data cleaning and preprocessing
2. Selecting the Top 200 anime titles by popularity
3. Creating user "baskets" of liked anime
4. Converting baskets into transaction format
5. Applying **association rule mining** using the `arules` package in R
6. Visualizing the discovered patterns using `arulesViz`

## Tools & Libraries

- R
- data.table
- dplyr
- arules
- arulesViz

## Key Idea

Association rule mining allows us to detect patterns such as:

> Users who liked Anime A are also likely to like Anime B.

This approach is commonly used in **market basket analysis**, recommendation systems, and preference modeling.

## Author

Arda Uzer  
