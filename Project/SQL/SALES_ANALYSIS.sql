-- ============================================================
-- Retail Sales And Performance Analytics
-- Superstore Dataset
-- ============================================================

-- 1. Overall Performance
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    SUM(Profit) / NULLIF(SUM(Sales), 0) AS Profit_Margin
FROM Fact_Sales;


-- 2. Sales and Profit by Category
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Profit) / NULLIF(SUM(Sales), 0) AS Profit_Margin
FROM Fact_Sales
GROUP BY Category
ORDER BY Total_Sales DESC;


-- 3. Segment Performance
SELECT
    Segment,
    COUNT(DISTINCT Customer_ID) AS Customers,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Profit) / NULLIF(SUM(Sales), 0) AS Profit_Margin
FROM Fact_Sales
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- 4. Regional Performance
SELECT
    Region,
    COUNT(DISTINCT Customer_ID) AS Customers,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Profit) / NULLIF(SUM(Sales), 0) AS Profit_Margin,
    SUM(Profit) / NULLIF(COUNT(DISTINCT Order_ID), 0) AS Profit_Per_Order
FROM Fact_Sales
GROUP BY Region
ORDER BY Total_Sales DESC;


-- 5. Category Profitability by Region
SELECT
    Region,
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Profit) / NULLIF(SUM(Sales), 0) AS Profit_Margin
FROM Fact_Sales
GROUP BY
    Region,
    Category
ORDER BY
    Region,
    Category;


-- 6. Product Performance
SELECT
    Product_ID,
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Profit) / NULLIF(SUM(Sales), 0) AS Profit_Margin,
    SUM(Quantity) AS Units_Sold
FROM Fact_Sales
GROUP BY
    Product_ID,
    Product_Name
ORDER BY Total_Sales DESC;


-- 7. Loss-Making Products
SELECT
    Product_ID,
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Fact_Sales
GROUP BY
    Product_ID,
    Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;


-- 8. Discount vs Profitability
SELECT
    Category,
    AVG(Discount) AS Average_Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Profit) / NULLIF(SUM(Sales), 0) AS Profit_Margin
FROM Fact_Sales
GROUP BY Category
ORDER BY Average_Discount DESC;


-- 9. Customer Performance
SELECT
    Customer_ID,
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Profit) / NULLIF(SUM(Sales), 0) AS Profit_Margin
FROM Fact_Sales
GROUP BY
    Customer_ID,
    Customer_Name
ORDER BY Total_Sales DESC;


-- 10. Yearly Sales
SELECT
    EXTRACT(YEAR FROM Order_Date) AS Sales_Year,
    SUM(Sales) AS Total_Sales
FROM Fact_Sales
GROUP BY EXTRACT(YEAR FROM Order_Date)
ORDER BY Sales_Year;
