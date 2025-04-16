# Profitability Diagnostics & Loss Root Cause Analysis Using Advanced SQL

## Description
This project utilizes SQL for root cause analysis, allowing the identification of underperforming products, high-risk customers, and unprofitable regions through drill-down queries. By leveraging advanced SQL techniques, it offers a data-driven approach to enhance decision-making and drive profitability improvements.
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

## Content
This project consists of 33 SQL queries, which cover various aspects of business profitability analysis:

### 📌Queries:
1. Overview Ship mode, Order priority
2. Trending Customer
3. Sales and Profit by Category
4. Bottom 10 Sub-Categories by Profit
5. Top 3 Lowest Profit Products in 'Tables' Sub-Category
6. Sales and Profit by Market for 3 Table Products
7. Sales and Profit by Segment for 3 Table Products
8. Sales by Region and Segment for 3 Table Products
9. Profit Over Time for 3 Table Products
10. Top 5 products with the lowest total profit
11. Sales, Profit and Discount by Market for Top 5 Loss Products
12. Sales and Profit Over Time for Top 5 Loss Products
13. Profit by Market
14. Profit by Region
15. Top 10 Countries with the Biggest Loss
16. Country with Most Loss in each Market
17. Number of Loss Orders by Country (Nigeria, Turkey, Netherlands, Honduras)
18. Top 3 Cities with Most Loss in Each Country
19. Category Performance in Nigeria
20. Top 10 Sub-Categories with Most Loss in Nigeria
21. Top 10 Products with Most Loss in Nigeria
22. Top 10 Nigeria Cities by Number of Loss Orders
23. Categories with Most Loss in Lagos city
24. Sub-Categories with Most Loss in Lagos city
25. Top 10 Products with Most Loss in Lagos city
26. All Orders in Lagos
27. Top 3 Orders with Biggest Loss in Amsterdam, Lagos, Istanbul, Tegucigalpa
28. Sales and Profit by Segment
29. Top 3 Customers with Most Loss in Each Segment
30. Total sales and profit for each segment in each market
31. Profit by Segment in Netherlands, Nigeria, Turkey, Honduras
32. Profit by Segment in Lagos, Amsterdam, Istanbul
33. Orders from Top 3 Loss-Making Customers in Each Segment

### 📌Procedures: 

- `15 stored procedures` have been developed to allow customizable input parameters such as Country, City, Product_ID, Sub_Category, etc., enabling flexible reuse for various data analysis queries. These procedures correspond to `query numbers 5, 8, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 30, and 31`. This enhances the efficiency of data analysis and provides solutions for a diverse range of real-world scenarios.

## Result

This project provides actionable insights to optimize business performance through advanced data analysis techniques, enabling informed decision-making and targeted interventions.

- **Product Portfolio Optimization**: By analyzing product profitability and identifying low-performing SKUs, the analysis highlights opportunities to prioritize high-margin products and eliminate or redesign underperforming items. This supports profit maximization and inventory management by focusing resources on the most profitable products.

- **Customer Segmentation Insights**: Through in-depth analysis of customer segments, the project reveals which customer groups contribute to profitability erosion and which segments are underperforming. These insights allow for the refinement of customer segmentation strategies, improving targeting and retention efforts, and optimizing customer lifetime value (CLV).

- **Geographic Profitability Focus**: The spatial analysis uncovers regions or cities with the highest profitability gaps and loss drivers. By identifying these areas, businesses can deploy localized strategies to optimize supply chain logistics, adjust marketing approaches, and better allocate resources in high-risk regions, driving greater regional profitability.

- **Discount Strategy Optimization**: The analysis of sales and profit data in relation to discounting strategies reveals the impact of promotions on the bottom line. Businesses can assess the effectiveness of their discounting practices and fine-tune promotional strategies to minimize revenue leakage, while still achieving desired sales targets.

- **Actionable Loss Drivers Identification**: By drilling down into underperforming products, customer segments, and regions, the analysis pinpoints key loss drivers, enabling businesses to take immediate corrective action. Whether it’s adjusting pricing, optimizing shipping costs, or rethinking customer outreach, these insights provide clear, data-driven paths to reduce losses and boost profitability.
