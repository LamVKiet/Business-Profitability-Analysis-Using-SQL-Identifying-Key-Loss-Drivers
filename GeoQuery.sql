--12. Profit by Market
Select Top 10 Market, 
	Round(Sum(Sales), 2) as Total_Sales,
	Round(Sum(Profit), 2)  as Total_Profit,
	Round((Sum(Profit) * 100 /Sum(Sales)), 2) as Percent_Profit 
from Orders
Group by Market
Order by Sum(Profit) ASC

--13. Profit by Region
Select Top 10 Market, Region,
	Round(Sum(Sales), 2) as Total_Sales,
	Round(Sum(Profit), 2)  as Total_Profit,
	Round((Sum(Profit) * 100 /Sum(Sales)), 2) as Percent_Profit 
from Orders
Group by Market, Region
Order by Sum(Profit) ASC

--14. Top 10 Countries with the Biggest Loss
Select 
	Top 10 Country,
	Round(Sum(Profit), 2) as Profit
from Orders
Group by Country
Order by Sum(Profit) ASC

--15. Country with Most Loss in each Market
With profit_rank as
(Select
    Market,
    Country,
    ROUND(SUM(Sales), 2) as Total_Sales_Country,
    ROUND(SUM(Profit), 2) as Total_Profit_Country,
    RANK() OVER (Partition by Market Order By SUM(Profit) ASC) as Profit_Rank
from Orders
Group by Market, Country
)
SELECT *
FROM profit_rank
WHERE Profit_Rank = 1 and Total_Profit_Country < 0
ORDER BY Market, Profit_Rank

--16. Number of Loss Orders by Country (Nigeria, Turkey, Netherlands, Honduras)
Select 
	Country,
	Count(Case when Profit < 0 then 1 end) as [Number_Loss_Order]
from Orders
where Country in ('Nigeria', 'Turkey', 'Netherlands', 'Honduras')
Group by Country
Order by [Number_Loss_Order] DESC

--17. Top 3 Cities with Most Loss in Each Country 
With most_loss_cities AS (
    Select 
        Country,
        City,
        ROUND(SUM(Sales), 2) as Total_Sales,
        ROUND(SUM(Profit), 2) as Total_Profit,
        ROW_NUMBER() OVER (Partition by Country Order by SUM(Profit) ASC) as city_rank
    from Orders
    where Country IN ('Turkey', 'Nigeria', 'Netherlands', 'Honduras')
    Group by Country, City
)
Select *
From most_loss_cities
Where city_rank <= 3
Order by Country, city_rank

--18. Category Performance in Nigeria
SELECT 
	Category,
	Sum(Sales) as Sales,
	Sum(Profit) as Profit,
	Round(Avg(Discount), 2) * 100 as [Avg_%_Discount],
	Round(Min(Discount), 2) * 100 as [Min_%_Discount],
	Round(Max(Discount), 2) * 100 as [Max_%_Discount]
FROM Orders
where Country = 'Nigeria'
Group by Category

--19. Top 10 Sub-Categories with Most Loss in Nigeria
SELECT 
	Top 10
	Sub_category,
	Sum(Sales) as Sales,
	Sum(Profit) as Profit
FROM Orders
where Country = 'Nigeria'
Group by Sub_category
Order by Profit ASC

--20. Top 10 Products with Most Loss in Nigeria
SELECT 
	Top 10
	Product_ID,
	Product_Name,
	Sum(Sales) as Sales,
	Sum(Profit) as Profit
FROM Orders
where Country = 'Nigeria'
Group by Product_ID, Product_Name
Order by Profit ASC

--21. Top 10 Nigeria Cities by Number of Loss Orders
Select 
	Top 10 City,
	Count(Case when Profit < 0 then 1 end) as [Number_Loss_Order]
from Orders
where Country = 'Nigeria'
Group by City
Order by [Number_Loss_Order] DESC

--22. Categories with Most Loss in Lagos city
SELECT 	
	Category,
	Sum(Sales) as Sales,
	Sum(Profit) as Profit
FROM Orders
where City = 'Lagos'
Group by Category
Order by Sum(Profit)

--23. Sub-Categories with Most Loss in Lagos city
SELECT 	
	Sub_category,
	Sum(Sales) as Sales,
	Sum(Profit) as Profit
FROM Orders
where City = 'Lagos'
Group by Sub_category
Order by Sum(Profit)

--24. Top 10 Products with Most Loss in Lagos city
SELECT 
	Top 10 Product_ID, Product_Name,
	Sum(Sales) as Sales,
	Sum(Profit) as Profit
FROM Orders
where City = 'Lagos'
Group by Product_ID, Product_Name
Order by Sum(Profit) ASC

--25. All Orders in Lagos 
SELECT 
    Order_Date, 
    Order_ID,
    Market,
	Region,
	Country,
	Category,
    Sales,
    Profit,
	Shipping_Cost,
    Discount * 100 AS [%_Discount],
	Case 
        when Discount = 0 then Sales 
        else Round((Sales / (1 - Discount)), 2) 
    End as Sales_no_discount,
	Case
		when Discount = 0 then Round(((Profit / Sales) * 100), 2)
		else Round((Profit / (Sales / (1 - Discount))), 2) * 100
	End as [%_Profit],
    SUM(Profit) OVER (PARTITION BY Category, Country ORDER BY Country, Order_Date ASC) AS running_profit
FROM Orders
where City = 'Lagos'

--26. Top 3 Orders with Biggest Loss in Amsterdam, Lagos, Istanbul, Tegucigalpa
with order_rank_city as(
Select     
    DATEPART(YEAR, Order_Date) AS Year,
    CONCAT('Q', DATEPART(QUARTER, Order_Date)) AS Quarter,
    Order_ID,
	Country,
	City,
	Segment,
	Sub_Category,
	Product_Name,
    Product_ID,
	Quantity,
    Sales,
    Profit,
	Discount,
    ROW_NUMBER() OVER (Partition by Country, City Order by Profit ASC) as order_rank
from Orders
where City IN ('Amsterdam', 'Lagos', 'Istanbul', 'Tegucigalpa')
)
Select * from order_rank_city
where order_rank <= 3
