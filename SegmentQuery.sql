--27. Sales and Profit by Segment
Select Top 10 Segment,
	Round(Sum(Sales), 2) as Total_Sales,
	Round(Sum(Profit), 2)  as Total_Profit,
	Round((Sum(Profit) * 100 /Sum(Sales)), 2) as Percent_Profit 
from Orders
Group by Segment
Order by Sum(Profit) Desc

--28. Top 3 Customers with Most Loss in Each Segment
With three_customer as (
Select Segment, Customer_ID, 
        ROUND(SUM(Sales), 2) as Total_Sales,
        ROUND(SUM(Profit), 2) as Total_Profit,
		Row_Number() Over(Partition by Segment Order by Sum(Profit) ASC) as segment_rank
		from Orders
		Group by Segment, Customer_ID
)
Select 
	Segment,
	Customer_ID,
    Total_Sales,
    Total_Profit
from three_customer
where segment_rank <= 3
Order by Segment, segment_rank

--29. Total sales and profit for each segment in each market.
Select	Market,
		Segment,
		Round(Sum(Sales), 2) as Total_Sales,
		Round(Sum(Profit), 2) as Total_Profit
from Orders
Group by Segment, Market
Order by Market, Sum(Profit) ASC

--30. Profit by Segment in Netherlands, Nigeria, Turkey, Honduras
Select	Country,
		Segment,
		Round(Sum(Sales), 2) as Total_Sales,
		Round(Sum(Profit), 2) as Total_Profit
from Orders
where Country in ('Netherlands', 'Nigeria', 'Turkey', 'Honduras')
Group by Country, Segment
order by Country, Total_Profit ASC

--31. Profit by Segment in Lagos, Amsterdam, Istanbul 
Select	City,
		Segment,
		Round(Sum(Sales), 2) as Total_Sales,
		Round(Sum(Profit), 2) as Total_Profit
from Orders
where City in ('Lagos', 'Amsterdam', 'Istanbul')
Group by City, Segment
order by City, Total_Profit ASC


--32. Orders from Top 3 Loss-Making Customers in Each Segment
WITH three_customer AS (
    SELECT 
        Segment, 
        Customer_ID, 
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(SUM(Profit), 2) AS Total_Profit,
        ROW_NUMBER() OVER (PARTITION BY Segment ORDER BY SUM(Profit) ASC) AS segment_rank
    FROM Orders
    GROUP BY Segment, Customer_ID
)
SELECT 
    DATEPART(YEAR, Order_Date) AS Year,
    CONCAT('Q', DATEPART(QUARTER, Order_Date)) AS Quarter,
    Order_ID,
    Customer_ID,
    Category,
    Sub_category,
    Product_ID,
	Market,
	Country,
    ROUND(SUM(Sales), 2) AS Sales, 
    ROUND(SUM(Profit), 2) AS Profit, 
    ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY SUM(Profit) ASC) AS order_rank_customer
FROM Orders
WHERE Customer_ID IN (
    SELECT Customer_ID
    FROM three_customer
    WHERE segment_rank <= 3
)
GROUP BY 
    Order_ID, 
    Customer_ID, 
    Order_Date, 
    Category, 
    Sub_category, 
    Product_ID,
	Market,
	Country
ORDER BY 
    Customer_ID