-- 1
/*
یک کد بر روی جدول dbo.orders
بنویسید که به ازای هر فروش مشتری مقدار rank , Dense Rank
را محاسبه کند و براساس custid
دسته بندی کرده و براساس qty 
مرتب سازی کنید
*/

select custid , orderid ,qty,
RANK() over(partition by custid order by qty) as rnk,
dense_rank() over(partition by custid order by qty) as drnk
from dbo.orders

-- Desired output:
custid orderid     qty         rnk                  drnk
------ ----------- ----------- -------------------- --------------------
A      30001       10          1                    1
A      40005       10          1                    1
A      10001       12          3                    2
A      40001       40          4                    3
B      20001       12          1                    1
B      30003       15          2                    2
B      10005       20          3                    3
C      10006       14          1                    1
C      20002       20          2                    2
C      30004       22          3                    3
D      30007       30          1                    1



-- 2
/*
یک کد بر روی جدول Dbo.orders 
 بنویسید که برای هر فروش مشتری:
 - اختلاف بین مقدار سفارش فعلی و مقدار سفارش قبلی همان مشتری را حساب کند
 - اختلاف بین مقدار سفارش فعلی و مقدار سفارش بعدی مشتری را حساب کند.
*/

select custid , orderid ,
(qty-lag(qty) over(partition by custid order by orderdate)) as diffprev ,
(qty-lead(qty) over(partition by custid order by orderdate)) as diffnext
from dbo.Orders

-- Desired output:
custid orderid     qty         diffprev    diffnext
------ ----------- ----------- ----------- -----------
A      30001       10          NULL        -2
A      10001       12          2           -28
A      40001       40          28          30
A      40005       10          -30         NULL
B      10005       20          NULL        8
B      20001       12          -8          -3
B      30003       15          3           NULL
C      30004       22          NULL        8
C      10006       14          -8          -6
C      20002       20          6           NULL
D      30007       30          NULL        NULL

-- 3
/*
کدی بر روی جدول dbo.orders 
که برای هر کارمند یک ردیف برگرداند ، یک ستون برای هر سال سفارش و تعداد سفارش برای هر 
کارمند و در هر سال
*/
-- Tables involved: TSQLV4 database, dbo.Orders table

select empid,[2014] as 'cnt2014' ,[2015] as 'cnt2015' ,[2016] as 'cnt2016'
from(select orderid,empid, year(orderdate) as year from dbo.Orders ) as do
pivot (count(orderid) for year in ([2014],[2015],[2016])) as p

-- Desired output:
empid       cnt2014     cnt2015     cnt2016
----------- ----------- ----------- -----------
1           1           1           1
2           1           2           1
3           2           0           2

