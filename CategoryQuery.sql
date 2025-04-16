-- 3. Sales and Profit by Category
Select Category, 
	Round(Sum(Sales), 2) as Total_Sales,
	Round(Sum(Profit), 2)  as Total_Profit,
	Round((Sum(Profit) * 100 /Sum(Sales)), 2) as Percent_Profit
from Orders
Group by Category
Order by Sum(Profit) ASC

-- 4. Bottom 10 Sub-Categories by Profit
Select top 10 Category, Sub_category,
	Round(Sum(Sales), 2) as Total_Sales,
	Round(Sum(Profit), 2)  as Total_Profit
from Orders
Group by Category, Sub_category
Order by Sum(Profit) ASC

-- 5. Top 3 Lowest Profit Products in 'Tables' Sub-Category
Select top 3 Sub_category, Product_ID, Product_Name,
	Round(Sum(Sales), 2) as Total_Sales,
	Round(Sum(Profit), 2)  as Total_Profit,
	Round(Avg(Discount), 2) * 100 as [Avg_%_Discount],
	Round(Min(Discount), 2) * 100 as [Min_%_Discount],
	Round(Max(Discount), 2) * 100 as [Max_%_Discount]
from Orders
where Sub_Category = 'Tables'
Group by Product_ID, Sub_category, Product_Name
Order by Sum(Profit) ASC

-- 6. Sales and Profit by Market for 3 Table Products
Select Market, Product_ID, Sum(Sales) as Sales, Sum(Profit) as Profit, Round(AVG(Discount), 2) * 100 as AVG_Discount
from Orders
where Product_ID IN ('FUR-TA-3429', 'FUR-TA-3418', 'FUR-TA-3753')
Group by  Market, Product_ID 
Order by Product_ID, Sum(Profit) asc

-- 7. Sales and Profit by Segment for 3 Table Products
Select Segment, Product_ID, Sum(Sales) as Sales, Sum(Profit) as Profit, Round(AVG(Discount), 2) * 100 as AVG_Discount
from Orders
where Product_ID IN ('FUR-TA-3429', 'FUR-TA-3418', 'FUR-TA-3753')
Group by  Segment, Product_ID 
Order by Product_ID, Sum(Profit) asc

-- 8. Sales by Region and Segment for 3 Table Products
Select Market, Segment, Product_ID, Sum(Sales) as Sales, Sum(Profit) as Profit, Round(AVG(Discount), 2) * 100 as AVG_Discount
from Orders
where Product_ID IN ('FUR-TA-3429', 'FUR-TA-3418', 'FUR-TA-3753')
Group by  Segment, Market, Product_ID 
Order by Product_ID, Sum(Profit) asc

-- 9. Profit Over Time for 3 Table Products
Select	Order_Date, 
		Order_ID,
		Market,
		Product_ID, 
		Sales,
		Profit,
		Discount * 100 as [%_Discount],
		Sum(Profit) Over(Partition by Product_ID order by Order_Date ASC) as running_profit
from Orders
where Product_ID IN ('FUR-TA-3429', 'FUR-TA-3418', 'FUR-TA-3753')

--9. Top 5 products with the lowest total profit.
Select top 5 Product_ID, Product_Name, Sub_category,
	Round(Sum(Sales), 2) as Total_Sales,
	Round(Sum(Profit), 2)  as Total_Profit
from Orders
Group by Product_ID, Sub_category, Product_Name
Order by Sum(Profit) ASC

--10. Sales, Profit and Discount by Market for Top 5 Loss Products
Select Market, Product_ID, Sum(Sales) as Sales, Sum(Profit) as Profit, Round(AVG(Discount), 2) * 100 as AVG_Discount
from Orders
WHERE Product_ID IN (
    SELECT TOP 5 Product_ID
    FROM Orders
    GROUP BY Product_ID
	Order by Sum(Profit) ASC)
Group by Market, Product_ID
Order by Product_ID, Sum(Profit) ASC

-- 11. Sales and Profit Over Time for Top 5 Loss Products
SELECT 
    Order_Date, 
    Order_ID,
    Market,
	Sub_Category,
	Product_Name,
    Product_ID,
	Quantity,
    Sales,
    Profit,
    Discount * 100 AS [%_Discount],
	Case 
        when Discount = 0 then Sales 
        else Round((Sales / (1 - Discount)), 2) 
    End as Sales_no_discount,
	Case
		when Discount = 0 then Round(((Profit / Sales) * 100), 2)
		else Round((Profit / (Sales / (1 - Discount))), 2) * 100
	End as [%_Profit],
    SUM(Profit) OVER (PARTITION BY Product_ID, Market ORDER BY Market, Order_Date ASC) AS running_profit
FROM Orders
WHERE Product_ID IN (
    SELECT TOP 5 Product_ID
    FROM Orders
    GROUP BY Product_ID
    ORDER BY SUM(Profit) ASC
) 