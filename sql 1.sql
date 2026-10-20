create database superstore ;
use superstore;
show tables;
desc superstore;
select * from superstore
limit 10;
select  'Order ID' ,'Ship Date' from superstore limit 10;
select * from superstore limit 5;
SELECT
    STR_TO_DATE(
        REPLACE(TRIM(`Order Date`), '/', '-'),
        '%m-%d-%Y'
    ) AS order_date,
    STR_TO_DATE(
        REPLACE(TRIM(`Ship Date`), '/', '-'),
        '%m-%d-%Y'
    ) AS ship_date
FROM superstore
LIMIT 10;
SELECT COUNT(*) AS invalid_dates
FROM superstore
WHERE
    STR_TO_DATE(
        REPLACE(TRIM(`Order Date`), '/', '-'),
        '%m-%d-%Y'
    ) IS NULL
    OR
    STR_TO_DATE(
        REPLACE(TRIM(`Ship Date`), '/', '-'),
        '%m-%d-%Y'
    ) IS NULL;
    use superstore;
    select count(*) total_sales
    from superstore;
    select * from superstore;
    -- category total_sales
    select category, sum(sales) total_sales
    from superstore
    group by category;
    -- region profit
    select Region ,sum(profit)
    from superstore
    group by Region;
    -- AVG  category profit
    select category , avg(profit) Avg_profit
    from superstore
    group by category;
    -- The company wants to see only product categories whose total sales are greater than 700,000.
    select  category , sum(sales)
    from superstore
    group by category
    having sum(sales) > 700000;
    -- The company wants to calculate total sales for each category, considering only orders with a discount greater than 0.20.
   select category , sum(sales)
   from superstore
   where discount > 0.20
   group by category;
   -- The company wants to rank product categories from highest to lowest total profit.
    select * from superstore;
    select category , sum(profit) total_profit
    from superstore
    group by category
    order by sum(profit) desc;
    --
    select region , count(*) count_region
    from superstore
    group by region;
    -- The company wants to find orders where the profit is greater than 500, then display the most profitable orders first.
     select 'order id' , profit sort_profit
     from superstore
     where profit > 500
     order by profit desc;
     -- The company wants to find product categories whose average profit is greater than 100 and display the highest average profit first.
     select category , avg(profit)
     from superstore
      group by category 
     order by avg(profit) desc;
     -- monthly sales
    SELECT
    DATE_FORMAT(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        ),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY sales_month
ORDER BY sales_month;
    -- month profit analysis
    SELECT
    DATE_FORMAT(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        ),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY sales_month
ORDER BY sales_month;
-- sales vs profit
SELECT
    DATE_FORMAT(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        ),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY sales_month
ORDER BY sales_month;
-- 
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
WHERE `Order Date` LIKE '%2014%'
GROUP BY Category;
--
SELECT `Order Date`
FROM superstore
WHERE `Order Date` LIKE '%2014%'
LIMIT 10;
    --
    SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Discount) * 100, 2) AS avg_discount_pct
FROM superstore
WHERE STR_TO_DATE(
    REPLACE(TRIM(`Order Date`), '/', '-'),
    '%m-%d-%Y'
) >= '2014-03-01'
AND STR_TO_DATE(
    REPLACE(TRIM(`Order Date`), '/', '-'),
    '%m-%d-%Y'
) < '2014-04-01'
GROUP BY Category
ORDER BY total_profit ASC;
--
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Discount) * 100, 2) AS avg_discount_pct
FROM superstore
WHERE STR_TO_DATE(
    REPLACE(TRIM(`Order Date`), '/', '-'),
    '%m-%d-%Y'
) >= '2014-03-01'
AND STR_TO_DATE(
    REPLACE(TRIM(`Order Date`), '/', '-'),
    '%m-%d-%Y'
) < '2014-04-01'
AND Category = 'Furniture'
GROUP BY `Product Name`
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC
LIMIT 10;
--
SELECT
    Discount,
    COUNT(*) AS order_rows,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
WHERE STR_TO_DATE(
    REPLACE(TRIM(`Order Date`), '/', '-'),
    '%m-%d-%Y'
) >= '2014-03-01'
AND STR_TO_DATE(
    REPLACE(TRIM(`Order Date`), '/', '-'),
    '%m-%d-%Y'
) < '2014-04-01'
AND Category = 'Furniture'
GROUP BY Discount
ORDER BY Discount;
--
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY Region
ORDER BY total_profit DESC;
-- year
SELECT
    YEAR(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_year,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY order_year
ORDER BY order_year;
-- month
SELECT
    MONTH(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_month,
    COUNT(*) AS total_records
FROM superstore
GROUP BY order_month
ORDER BY order_month;
-- year + month
SELECT
    YEAR(STR_TO_DATE(REPLACE(TRIM(`Order Date`), '/', '-'), '%m-%d-%Y')) AS order_year,
    MONTH(STR_TO_DATE(REPLACE(TRIM(`Order Date`), '/', '-'), '%m-%d-%Y')) AS order_month,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
-- date_function
SELECT
    DATE_FORMAT(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        ),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY sales_month
ORDER BY sales_month;
-- CTE
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(
                REPLACE(TRIM(`Order Date`), '/', '-'),
                '%m-%d-%Y'
            ),
            '%Y-%m'
        ) AS sales_month,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY sales_month
)
SELECT
    sales_month,
    ROUND(total_sales, 2) AS total_sales
FROM monthly_sales
WHERE total_sales > 30000
ORDER BY sales_month;
-- rank
SELECT
    Category,
    `Product Name`,
    ROUND(SUM(Profit), 2) AS total_profit,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Profit) DESC
    ) AS profit_rank
FROM superstore
GROUP BY Category, `Product Name`;
-- row no
SELECT
    Category,
    `Product Name`,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROW_NUMBER() OVER (
        PARTITION BY Category
        ORDER BY SUM(Profit) DESC
    ) AS row_num
FROM superstore
GROUP BY Category, `Product Name`;
-- dens rank
SELECT
    Category,
    `Product Name`,
    ROUND(SUM(Profit), 2) AS total_profit,
    DENSE_RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Profit) DESC
    ) AS profit_rank
FROM superstore
GROUP BY Category, `Product Name`;
-- LAG
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(
                REPLACE(TRIM(`Order Date`), '/', '-'),
                '%m-%d-%Y'
            ),
            '%Y-%m'
        ) AS sales_month,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY sales_month
)
SELECT
    sales_month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        LAG(total_sales) OVER (ORDER BY sales_month),
        2
    ) AS previous_month_sales
FROM monthly_sales
ORDER BY sales_month;
-- LEAD()
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(
                REPLACE(TRIM(`Order Date`), '/', '-'),
                '%m-%d-%Y'
            ),
            '%Y-%m'
        ) AS sales_month,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY sales_month
)
SELECT
    sales_month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        LEAD(total_sales) OVER (ORDER BY sales_month),
        2
    ) AS next_month_sales
FROM monthly_sales
ORDER BY sales_month;
-- sum() over()
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(
                REPLACE(TRIM(`Order Date`), '/', '-'),
                '%m-%d-%Y'
            ),
            '%Y-%m'
        ) AS sales_month,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY sales_month
)
SELECT
    sales_month,
    ROUND(total_sales, 2) AS monthly_sales,
    ROUND(
        SUM(total_sales) OVER (
            ORDER BY sales_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS running_total
FROM monthly_sales
ORDER BY sales_month;
-- subqueies
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(
                REPLACE(TRIM(`Order Date`), '/', '-'),
                '%m-%d-%Y'
            ),
            '%Y-%m'
        ) AS sales_month,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY sales_month
)
SELECT
    sales_month,
    ROUND(total_sales, 2) AS total_sales
FROM monthly_sales
WHERE total_sales > (
    SELECT AVG(monthly_total)
    FROM (
        SELECT SUM(Sales) AS monthly_total
        FROM superstore
        GROUP BY DATE_FORMAT(
            STR_TO_DATE(
                REPLACE(TRIM(`Order Date`), '/', '-'),
                '%m-%d-%Y'
            ),
            '%Y-%m'
        )
    ) AS monthly_average
)
ORDER BY total_sales DESC;
-- exits()
SELECT DISTINCT s1.Category
FROM superstore s1
WHERE EXISTS (
    SELECT 1
    FROM superstore s2
    WHERE s2.Category = s1.Category
      AND s2.Profit < 0
);
-- not exits
SELECT DISTINCT s1.Category
FROM superstore s1
WHERE NOT EXISTS (
    SELECT 1
    FROM superstore s2
    WHERE s2.Category = s1.Category
      AND s2.Profit < 0
);
-- 
SELECT
    Category,
    SUM(CASE WHEN Profit < 0 THEN 1 ELSE 0 END) AS loss_records
FROM superstore
GROUP BY Category;
-- Coalesce
SELECT
    `Order ID`,
    Profit,
    COALESCE(Profit, 0) AS profit_checked
FROM superstore
LIMIT 10;
-- nullif()
SELECT
    `Order ID`,
    Sales,
    Discount,
    Sales / NULLIF(Discount, 0) AS sales_per_discount
FROM superstore
LIMIT 10;
-- cast
SELECT
    `Order ID`,
    Sales,
    CAST(Sales AS DECIMAL(10,2)) AS formatted_sales
FROM superstore
LIMIT 10;
-- datriff()
SELECT
    `Order ID`,
    STR_TO_DATE(
        REPLACE(TRIM(`Order Date`), '/', '-'),
        '%m-%d-%Y'
    ) AS order_date,
    STR_TO_DATE(
        REPLACE(TRIM(`Ship Date`), '/', '-'),
        '%m-%d-%Y'
    ) AS ship_date,
    DATEDIFF(
        STR_TO_DATE(
            REPLACE(TRIM(`Ship Date`), '/', '-'),
            '%m-%d-%Y'
        ),
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS shipping_days
FROM superstore
LIMIT 10;
--
SELECT
    YEAR(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_year,
    QUARTER(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_quarter,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY order_year, order_quarter
ORDER BY order_year, order_quarter;
--
SELECT
    YEAR(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_year,
    QUARTER(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_quarter,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY order_year, order_quarter
ORDER BY order_year, order_quarter;
--
SELECT
    `Product Name`,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY `Product Name`, Category
ORDER BY total_profit DESC
LIMIT 10;
--
SELECT
    `Product Name`,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY `Product Name`, Category
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC
LIMIT 10;
--
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY Region
ORDER BY profit_margin_pct DESC;
--
SELECT
    Discount,
    COUNT(*) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY Discount
ORDER BY Discount;
--
SELECT
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_profit DESC
LIMIT 10;
--
SELECT
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    ROUND(AVG(
        DATEDIFF(
            STR_TO_DATE(REPLACE(TRIM(`Ship Date`), '/', '-'), '%m-%d-%Y'),
            STR_TO_DATE(REPLACE(TRIM(`Order Date`), '/', '-'), '%m-%d-%Y')
        )
    ), 2) AS avg_shipping_days,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY `Ship Mode`
ORDER BY avg_shipping_days;
-- state
SELECT
    State,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY State
ORDER BY total_profit DESC;
-- segment
SELECT
    Segment,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY Segment
ORDER BY total_profit DESC;
-- YOy
WITH yearly_sales AS (
    SELECT
        YEAR(
            STR_TO_DATE(
                REPLACE(TRIM(`Order Date`), '/', '-'),
                '%m-%d-%Y'
            )
        ) AS order_year,
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY order_year
),
sales_comparison AS (
    SELECT
        order_year,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY order_year
        ) AS previous_year_sales
    FROM yearly_sales
)
SELECT
    order_year,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(previous_year_sales, 2) AS previous_year_sales,
    ROUND(
        (total_sales - previous_year_sales)
        / NULLIF(previous_year_sales, 0) * 100,
        2
    ) AS yoy_growth_pct
FROM sales_comparison
ORDER BY order_year;
--
SELECT
    Category,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(
        CASE
            WHEN Profit < 0 THEN 1
            ELSE 0
        END
    ) AS loss_records
FROM superstore
GROUP BY Category
ORDER BY total_profit ASC;
-- top 10 customer 
SELECT
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_profit DESC
LIMIT 10;
-- top 10 customer by sale
SELECT
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;
-- category wise profut margin
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY Category
ORDER BY profit_margin_pct DESC;
-- year wise sales
SELECT
    YEAR(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY order_year
ORDER BY order_year;
-- monthly sales trends
SELECT
    YEAR(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_year,
    MONTH(
        STR_TO_DATE(
            REPLACE(TRIM(`Order Date`), '/', '-'),
            '%m-%d-%Y'
        )
    ) AS order_month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM superstore
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
--
SELECT
    `Order Date`,
    COUNT(*) AS total
FROM `superstore superstore`
GROUP BY `Order Date`
LIMIT 10;
USE superstore;
SHOW TABLES;
show tables;
USE superstore;

SELECT `Order Date`
FROM superstore
LIMIT 10;
---
SELECT
    `Order Date`,
    STR_TO_DATE(`Order Date`, '%d-%m-%Y') AS converted_date
FROM superstore
LIMIT 20;
--
SELECT
    `Order Date`,
    CASE
        WHEN `Order Date` LIKE '%-%' THEN
            STR_TO_DATE(`Order Date`, '%d-%m-%Y')
        WHEN `Order Date` LIKE '%/%' THEN
            STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    END AS converted_date
FROM superstore
LIMIT 30;
--
SELECT COUNT(*) AS total_rows,
       SUM(
           CASE
               WHEN `Order Date` IS NOT NULL
                    AND (
                        (`Order Date` LIKE '%-%'
                         AND STR_TO_DATE(`Order Date`, '%d-%m-%Y') IS NULL)
                        OR
                        (`Order Date` LIKE '%/%'
                         AND STR_TO_DATE(`Order Date`, '%m/%d/%Y') IS NULL)
                    )
               THEN 1
               ELSE 0
           END
       ) AS conversion_errors
FROM superstore;
--
SELECT
    `Order Date`,
    CASE
        WHEN `Order Date` LIKE '%-%'
            THEN STR_TO_DATE(`Order Date`, '%d-%m-%Y')
        WHEN `Order Date` LIKE '%/%'
            THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    END AS Order_Date_Clean
FROM superstore
LIMIT 10;
--
SELECT COUNT(*) AS total_rows
FROM superstore;
--
SELECT
    *,
    CASE
        WHEN `Order Date` LIKE '%-%'
            THEN STR_TO_DATE(`Order Date`, '%d-%m-%Y')
        WHEN `Order Date` LIKE '%/%'
            THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    END AS Order_Date_Clean
FROM superstore;


    