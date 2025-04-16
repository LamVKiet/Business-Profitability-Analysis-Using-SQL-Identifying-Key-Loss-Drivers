# Profitability Diagnostics & Loss Root Cause Analysis Using Advanced SQL

## Description
This project utilizes SQL for root cause analysis, allowing the identification of underperforming products, high-risk customers, and unprofitable regions through drill-down queries. By leveraging advanced SQL techniques such as Subqueries, Window Functions, CTEs, Grouping & Aggregation, CASE Statements, and Stored Procedures, it offers a data-driven approach to enhance decision-making and drive profitability improvements.
## Goal

Use SQL to analyze profitability, identify loss drivers, and provide actionable insights to enhance business performance.
## Guidelines 

This project includes SQL scripts for analyzing business data using customizable stored procedures and queries. Please follow the steps below to set up and run the code:

### Preparing dataset:

To run the queries and procedures, ensure you have a table named `Orders` with a structure similar to the **Global Superstore** dataset. You may download the sample **Global Superstore** dataset from platforms such as [Tableau](https://www.tableau.com/sites/default/files/training/global_superstore.zip) — typically as a .csv file — and import it into SQL.

### Opening the SQL Files:

There are **5 main SQL files** included in this project:
- `OverviewQuery.sql:` Includes general queries that provide a broad view of the dataset, such as overall shipping costs, customer trends.
- `GeoQuery.sql:` Enables spatial analysis with drill-downs by market, region, country, and city to uncover geographic patterns in sales and profitability.
- `CategoryQuery.sql:` Supports product performance evaluation across categories and sub-categories, identifying declining profitability, underperforming products, and key factors behind financial losses.
- `SegmentQuery.sql:` Analyzes predefined customer segments, identifies loss-making segments by region, drills down to unprofitable customers, and further to their most unprofitable orders — enabling data-driven root cause analysis and targeted business interventions.
- `Stored_Procedures.sql:` Contains 15 reusable stored procedures that accept input parameters such as Country, City, Product_ID, and Sub_Category, allowing for flexible filtering and repeated use across different data analysis scenarios.
  
To open the files:
- Use **SQL Server Management Studio (SSMS)**, or any SQL editor of your choice.
- Make sure you're connected to the appropriate database before running the scripts.

## Query Structure

This project consists of 33 SQL queries, which cover various aspects of business profitability analysis:

### 📌Queries:

1. Overview of Ship Mode and Order Priority.  
2. Trending Customers.  
3. Sales and Profit by Category.  
4. Bottom 10 Sub-Categories by Profit. ('Tables' is the Lowest Profit Sub-category).  
5. Top 3 Lowest Profit Products in the 'Tables' Sub-category.  
6. Sales and Profit by Market for the Top 3 Lowest Profit Table Products.  
7. Sales and Profit by Segment for the Top 3 Lowest Profit Table Products.  
8. Sales by Region and Segment for the Top 3 Lowest Profit Table Products.  
9. Profit Over Time for the Top 3 Lowest Profit Table Products.  
10. Overview of the Top 5 Products with the Lowest Total Profit.  
11. Sales, Profit, and Average Discount by Market for the Top 5 Loss Products.  
12. Sales and Profit Over Time for the Top 5 Loss Products.  
13. Overview of Profit by Market.  
14. Overview of Profit by Region.  
15. Top 10 Countries with the Biggest Losses.  
16. Country with the Most Loss in Each Market.  
17. Number of Loss Orders by Countries with the Biggest Losses (Nigeria, Turkey, Netherlands, Honduras).  
18. Top 3 Cities with the Most Loss in Each Country.  
19. Category Performance in Nigeria. (Choose Nigeria for drill-down queries).  
20. Top 10 Sub-categories with the Most Loss in Nigeria.  
21. Top 10 Products with the Most Loss in Nigeria.  
22. Top 10 Nigerian Cities by Number of Loss Orders. (Lagos is the highest).  
23. Categories with the Most Loss in Lagos City.  
24. Sub-categories with the Most Loss in Lagos City.  
25. Top 10 Products with the Most Loss in Lagos City.  
26. All Orders in Lagos.  
27. Top 3 Orders with the Biggest Loss in Amsterdam, Lagos, Istanbul, Tegucigalpa. (The cities with the highest losses in Nigeria, Turkey, Netherlands, Honduras).  
28. Sales and Profit by Segment.  
29. Top 3 Customers with the Most Loss in Each Segment.  
30. Total Sales and Profit for Each Segment in Each Market.  
31. Profit by Segment in Netherlands, Nigeria, Turkey, and Honduras.  
32. Profit by Segment in Lagos, Amsterdam, and Istanbul.  
33. Orders from the Top 3 Loss-Making Customers in Each Segment.  

### 📌Procedures: 

- `15 stored procedures` have been developed to allow customizable input parameters such as Country, City, Product_ID, Sub_Category, etc., enabling flexible reuse for various data analysis queries. These procedures correspond to `query numbers 5, 8, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 30, and 31`. This enhances the efficiency of data analysis and provides solutions for a diverse range of real-world scenarios.

## Result

This project provides actionable insights to optimize business performance through advanced data analysis techniques, enabling informed decision-making and targeted interventions.

- **Product Portfolio Optimization**: By analyzing product profitability and identifying low-performing SKUs, the analysis highlights opportunities to prioritize high-margin products and eliminate or redesign underperforming items. This supports profit maximization and inventory management by focusing resources on the most profitable products.

- **Customer Segmentation Insights**: Through in-depth analysis of customer segments, the project reveals which customer groups contribute to profitability erosion and which segments are underperforming. These insights allow for the refinement of customer segmentation strategies, improving targeting and retention efforts, and optimizing customer lifetime value (CLV).

- **Geographic Profitability Focus**: The spatial analysis uncovers regions or cities with the highest profitability gaps and loss drivers. By identifying these areas, businesses can deploy localized strategies to optimize supply chain logistics, adjust marketing approaches, and better allocate resources in high-risk regions, driving greater regional profitability.

- **Discount Strategy Optimization**: The analysis of sales and profit data in relation to discounting strategies reveals the impact of promotions on the bottom line. Businesses can assess the effectiveness of their discounting practices and fine-tune promotional strategies to minimize revenue leakage, while still achieving desired sales targets.

- **Actionable Loss Drivers Identification**: By drilling down into underperforming products, customer segments, and regions, the analysis pinpoints key loss drivers, enabling businesses to take immediate corrective action. Whether it’s adjusting pricing, optimizing shipping costs, or rethinking customer outreach, these insights provide clear, data-driven paths to reduce losses and boost profitability.
