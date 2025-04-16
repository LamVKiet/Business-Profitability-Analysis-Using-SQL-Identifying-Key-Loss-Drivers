-- 1. Overview Ship mode, Order priority.
Select	Ship_Mode,
		Order_Priority, 
		Round(Avg(Shipping_Cost), 2) as Avg_Shipping_Cost, 
		Round(STDEV(Shipping_Cost), 2) as Std_SC
From Orders
Group by Ship_Mode, Order_Priority
Order by Ship_Mode, Order_Priority


--2. Trending Customer 
Select 
    Datepart(Year, Order_Date) as Year,
    Concat('Q', Datepart(Quarter, Order_Date)) as [Quarter],
    Round(SUM(Sales), 2) as Total_Sales,
    Round(SUM(Profit), 2) as Total_Profit,
    Count(Case when Discount >= 0.4 then 1 end) as [Discount >= 40%_Count]
From Orders
Group by Datepart(Year, Order_Date), Datepart(Quarter, Order_Date)
Order by Year, Quarter


