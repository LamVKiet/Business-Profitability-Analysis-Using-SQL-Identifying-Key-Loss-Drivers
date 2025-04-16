-- 5. Procedure of Top 3 Lowest Profit Products by Sub-Category
Create Procedure Top3LossProductsBySubCategory
    @SubCategory Nvarchar(50)
As
Begin
    Select Top 3 
        Sub_Category, 
        Product_ID, 
        Product_Name,
        Round(Sum(Sales), 2) As Total_Sales,
        Round(Sum(Profit), 2) As Total_Profit,
        Round(Avg(Discount), 2) * 100 As [Avg_%_Discount],
        Round(Min(Discount), 2) * 100 As [Min_%_Discount],
        Round(Max(Discount), 2) * 100 As [Max_%_Discount]
    From Orders
    Where Sub_Category = @SubCategory
    Group By Product_ID, Sub_Category, Product_Name
    Order By Sum(Profit) Asc;
End

Exec Top3LossProductsBySubCategory @SubCategory = 'Tables';

-- 8. Procedure of Sales by Region and Segment by Product_ID
Create Procedure ProductBySubcategory
    @ProductList Nvarchar(Max)
As
Begin
    With ProductTable As (
        Select Trim(Value) As Product_ID From String_Split(@ProductList, ',')
    )
    Select 
        Market, 
        Segment, 
        o.Product_ID, 
        Sum(Sales) As Sales, 
        Sum(Profit) As Profit, 
        Round(Avg(Discount), 2) * 100 As AVG_Discount
    From Orders o
    Inner Join ProductTable p On o.Product_ID = p.Product_ID
    Group By Segment, Market, o.Product_ID
    Order By o.Product_ID, Sum(Profit) Asc;
End

Exec ProductBySubcategory @ProductList = 'FUR-TA-3429, FUR-TA-3418, FUR-TA-3753'

--16. Procedure of Number Loss Orders by Country
Create Procedure NumberLossOrdersByCountry
    @CountryList Nvarchar(Max)
As
Begin
    With CountryTable As (
        Select Trim(Value) As Country From String_Split(@CountryList, ',')
    ),
    FilteredOrders As (
        Select * 
        From Orders
        Where Country In (Select Country From CountryTable)
    )
    Select 
        Country,
        Count(Case When Profit < 0 Then 1 End) As Number_Loss_Order
    From FilteredOrders
    Group By Country
    Order By Number_Loss_Order Desc;
End


Exec NumberLossOrdersByCountry @CountryList = 'Turkey, Nigeria, Netherlands, Honduras'

--17. Procedure of Top 3 Loss Cites by Country 
Create procedure Top3LossCitiesByCountry
    @CountryList Nvarchar(MAX)
AS
BEGIN
    With CountryTable AS (
        Select Trim(value) AS Country from String_split(@CountryList, ',')
    ),
    FilteredOrders AS (
        SELECT * 
        FROM Orders
        WHERE Country IN (SELECT Country FROM CountryTable)
    ),
    Most_Loss_Cities AS (
        SELECT 
            o.Country,
            o.City,
            ROUND(SUM(o.Sales), 2) AS Total_Sales,
            ROUND(SUM(o.Profit), 2) AS Total_Profit,
            ROW_NUMBER() OVER (PARTITION BY o.Country ORDER BY SUM(o.Profit) ASC) AS city_rank
        FROM FilteredOrders o
        GROUP BY o.Country, o.City
    )
    SELECT *
    FROM Most_Loss_Cities
    WHERE city_rank <= 3
    ORDER BY Country, city_rank;
END

EXEC Top3LossCitiesByCountry @CountryList = 'Turkey, Nigeria, Netherlands, Honduras';

--18. Category Performance by Country
Create Procedure CategoryByCountries
    @CountryList Nvarchar(Max)
As
Begin
    With CountryTable As (
        Select Trim(Value) As Country From String_Split(@CountryList, ',')
    ),
    FilteredOrders As (
        Select *
        From Orders
        Where Country In (Select Country From CountryTable)
    )
    Select 
		Country,
        Category,
        Sum(Sales) As Sales,
        Sum(Profit) As Profit,
        Round(Avg(Discount), 2) * 100 As [Avg_%_Discount],
        Round(Min(Discount), 2) * 100 As [Min_%_Discount],
        Round(Max(Discount), 2) * 100 As [Max_%_Discount]
    From FilteredOrders
    Group By Category, Country;
End

Exec CategoryByCountries @CountryList = 'Turkey, Netherlands'

--19. Procedure of Top 10 Loss Sub-Categories by Country
Create Procedure Top10LossSubCategoryByCountries
    @CountryList Nvarchar(Max)
As
Begin
    With CountryTable As (
        Select Trim(Value) As Country From String_Split(@CountryList, ',')
    ),
    FilteredOrders As (
        Select *
        From Orders
        Where Country In (Select Country From CountryTable)
    )
    Select Top 10
        Sub_category,
        Sum(Sales) As Sales,
        Sum(Profit) As Profit
    From FilteredOrders
    Group By Sub_category
    Order By Profit Asc;
End

Exec Top10LossSubCategoryByCountries @CountryList = 'Nigeria'

--20. Procedure of Top 10 Loss Products by Country 
Create Procedure Top10LossProductsByCountries
    @CountryList Nvarchar(Max)
As
Begin
    With CountryTable As (
        Select Trim(Value) As Country From String_Split(@CountryList, ',')
    ),
    FilteredOrders As (
        Select *
        From Orders
        Where Country In (Select Country From CountryTable)
    )
    Select Top 10
		Country,
        Product_ID,
        Product_Name,
        Sum(Sales) As Sales,
        Sum(Profit) As Profit
    From FilteredOrders
    Group By Country, Product_ID, Product_Name
    Order By Country, Profit Asc;
End

Exec Top10LossProductsByCountries @CountryList = 'Nigeria';

--21. Procedure of Top 10 Number Loss Orders each city by country
Create Procedure Top10LossOrdersCitiesbyCountry
    @CountryName Nvarchar(255)
As
Begin
    Select 
        Top 10 
        City,
        Count(Case When Profit < 0 Then 1 End) As Number_Loss_Order
    From Orders
    Where Country = @CountryName
    Group By City
    Order By Number_Loss_Order Desc;
End

Exec Top10LossOrdersCitiesbyCountry @CountryName = 'Nigeria'

--22. Procedure of Categories with Most Loss by City
Create Procedure CategoryByCity
    @CityName Nvarchar(20)
As
Begin
    Select 	
        Category,
        Sum(Sales) As Sales,
        Sum(Profit) As Profit
    From Orders
    Where City = @CityName
    Group By Category
    Order By Sum(Profit) Desc;
End

Exec CategoryByCity @CityName = 'Lagos'


--23. Procedure of Top Loss Sub-Categories by city
Create procedure Top10SubcategoryLossbyCity
	@CityName Nvarchar(20)
As
Begin
	Select 
		Top 10
		Sub_category,
		Sum(Sales) As Sales,
        Sum(Profit) As Profit
    From Orders
    Where City = @CityName
    Group By Sub_category
    Order By Sum(Profit) Asc;
End

Exec Top10SubcategoryLossbyCity @CityName = 'Lagos'

--24. Procedure of Top 10 Loss Products by city
Create procedure Top10ProductsLossbyCity
	@CityName Nvarchar(20)
As
Begin
	Select top 10
		Product_ID,
		Product_Name,
		Sum(Sales) as Sales,
		Sum(Profit) as Profit
	from Orders
	where City = @CityName
	Group by Product_ID, Product_Name
	Order by Sum(Profit) ASC
End

Exec Top10ProductsLossbyCity @CityName = 'Lagos'

--30. Procedure of Profit by Segment by Country
Create Procedure ProfitCountryBySegment
    @CountryList Nvarchar(Max)
As
Begin
    With CountryTable As (
        Select Trim(Value) As Country From String_Split(@CountryList, ',')
    )
    Select 
        o.Country,
        o.Segment,
        Round(Sum(Sales), 2) As Total_Sales,
        Round(Sum(Profit), 2) As Total_Profit
    From Orders o
    Inner Join CountryTable c On o.Country = c.Country
    Group By o.Country, o.Segment
    Order By o.Country, Total_Profit Asc;
End

Exec ProfitCountryBySegment @CountryList = 'Netherlands,Nigeria,Turkey,Honduras';

--25. Procedure of All Orders by City
Create Procedure OrderDetailsByCityAndTime
    @CityName Nvarchar(20)
As
Begin
    Select 
        Order_Date, 
        Order_ID,
        Market,
        Region,
        Country,
        Category,
        Sales,
        Profit,
        Shipping_Cost,
        Discount * 100 As [%_Discount],
        Case 
            When Discount = 0 Then Sales 
            Else Round((Sales / (1 - Discount)), 2) 
        End As Sales_no_discount,
        Case
            When Discount = 0 Then Round(((Profit / Sales) * 100), 2)
            Else Round((Profit / (Sales / (1 - Discount))), 2) * 100
        End As [%_Profit],
        Sum(Profit) Over (Partition By Category, Country Order By Country, Order_Date Asc) As running_profit
    From Orders
    Where City = @CityName
    Order By Order_Date;
End

Exec OrderDetailsByCityAndTime @CityName = 'Lagos'

--26. Procedure of Top 3 Orders with Biggest Loss by City
Create Procedure Top3LossOrdersbyCities
    @CityList Nvarchar(Max)
As
Begin
    With Order_Rank_City As (
        Select     
            DatePart(Year, Order_Date) As Year,
            Concat('Q', DatePart(Quarter, Order_Date)) As Quarter,
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
            Row_Number() Over (Partition By Country, City Order By Profit Asc) As Order_Rank
        From Orders
        Where City In (Select Trim(Value) From String_Split(@CityList, ','))
    )
    Select * 
    From Order_Rank_City
    Where Order_Rank <= 3;
End

Exec Top3LossOrdersbyCities @CityList = 'Lagos'
--31. Procedure of Profit by Segment by City
Create Procedure ProfitCityBySegment
    @CityList Nvarchar(Max)
As
Begin
    With CityTable As (
        Select Trim(Value) As City From String_Split(@CityList, ',')
    )
    Select 
        o.City,
        o.Segment,
        Round(Sum(Sales), 2) As Total_Sales,
        Round(Sum(Profit), 2) As Total_Profit
    From Orders o
    Inner Join CityTable c On o.City = c.City
    Group By o.City, o.Segment
    Order By o.City, Total_Profit Asc;
End

Exec ProfitCityBySegment @CityList = 'Lagos, Amsterdam, Istanbul';
