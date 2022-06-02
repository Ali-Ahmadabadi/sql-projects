

-- 1
/*
تفاوت بین Union , Union All
را توضیح دهید و اینکه در چه شرایطی نتیجه آنها با هم برابر است و کدام باید به کار رود؟
*/
--dar union record haye moshtarak hazf mishavad vali dar union all record haye moshtarak niz dar natije hastand, zamani in do ta natije yeksani darand ke do majmue recordhaye gheire moshtarak nadashte bashand


-- 2
/*
کدی بنویسید که مشتری و فروشنده هایی را به صورت موازی نمایش دهد که در تاریخ 
January 2016 فروش داشتند
ولی در تاریخ February 2016
فعالیتی نداشتند
*/
-- Tables involved: TSQLV4 database, Orders table

select custid,empid
from sales.Orders
where year(orderdate)=2016 and month(orderdate)=1
except
select custid,empid
from sales.Orders
where year(orderdate)=2016 and month(orderdate)=2

--Desired output
custid      empid
----------- -----------
1           1
3           3
5           8
5           9
6           9
7           6
9           1
12          2
16          7
17          1
20          7
24          8
25          1
26          3
32          4
38          9
39          3
40          2
41          2
42          2
44          8
47          3
47          4
47          8
49          7
55          2
55          3
56          6
59          8
63          8
64          9
65          3
65          8
66          5
67          5
70          3
71          2
75          1
76          2
76          5
80          1
81          1
81          3
81          4
82          6
84          1
84          3
84          4
88          7
89          4

(50 row(s) affected)

-- 3
/*
کدی بنویسید که مشتری و فروشنده را باهم نمایش دهد که در هر دوتاریخ 
january 2016 and February 2016
فروش داشتند
*/

select custid,empid
from sales.Orders
where year(orderdate)=2016 and month(orderdate)=1
intersect
select custid,empid
from sales.Orders
where year(orderdate)=2016 and month(orderdate)=2

--Desired output
custid      empid
----------- -----------
20          3
39          9
46          5
67          1
71          4

(5 row(s) affected)

-- 4
/*
		January 2016 and February 2016 مشتریان و فروشندگانی که به صورت موازی در تاریخهای 
		فروش داشتند ولی در سال 2015 فعالیتی نداشتند
*/
-- Tables involved: TSQLV4 database, Orders table

from sales.Orders
where year(orderdate)=2016 and month(orderdate)=1
intersect
select custid,empid
from sales.Orders
where year(orderdate)=2016 and month(orderdate)=2
except
select custid,empid
from sales.Orders
where year(orderdate)=2015

--Desired output
custid      empid
----------- -----------
67          1
46          5

(2 row(s) affected)

-- 6 (Optional, Advanced)
SELECT country, region, city
FROM HR.Employees

UNION ALL

SELECT country, region, city
FROM Production.Suppliers;


