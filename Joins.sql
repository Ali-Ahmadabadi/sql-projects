-- 1
-- 1-1
/*
کدی بنویسید که برای هر مشتری 5 کپی از آن را ایجاد کند
*/
-- جداول مورد نیاز: TSQLV4 database, Employees and Nums tables

--Desired output

select empid,firstname,lastname,n
from hr.Employees
cross join dbo.Nums 
where n<6
order by n

empid       firstname  lastname             n
----------- ---------- -------------------- -----------
1           Sara       Davis                1
2           Don        Funk                 1
3           Judy       Lew                  1
4           Yael       Peled                1
5           Sven       Mortensen            1
6           Paul       Suurs                1
7           Russell    King                 1
8           Maria      Cameron              1
9           Patricia   Doyle                1
1           Sara       Davis                2
2           Don        Funk                 2
3           Judy       Lew                  2
4           Yael       Peled                2
5           Sven       Mortensen            2
6           Paul       Suurs                2
7           Russell    King                 2
8           Maria      Cameron              2
9           Patricia   Doyle                2
1           Sara       Davis                3
2           Don        Funk                 3
3           Judy       Lew                  3
4           Yael       Peled                3
5           Sven       Mortensen            3
6           Paul       Suurs                3
7           Russell    King                 3
8           Maria      Cameron              3
9           Patricia   Doyle                3
1           Sara       Davis                4
2           Don        Funk                 4
3           Judy       Lew                  4
4           Yael       Peled                4
5           Sven       Mortensen            4
6           Paul       Suurs                4
7           Russell    King                 4
8           Maria      Cameron              4
9           Patricia   Doyle                4
1           Sara       Davis                5
2           Don        Funk                 5
3           Judy       Lew                  5
4           Yael       Peled                5
5           Sven       Mortensen            5
6           Paul       Suurs                5
7           Russell    King                 5
8           Maria      Cameron              5
9           Patricia   Doyle                5

(45 row(s) affected)



-- 2
/*
در کد زیر چه خطایی وجود دارد ، آنرا اصلاح کنید.
*/
SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
FROM Sales.Customers AS C
  INNER JOIN Sales.Orders AS O
    ON Customers.custid = Orders.custid;

	SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
ON C.custid = O.custid;

-- 3
/*
مشتریان US برگردانده شود
و برای هر مشتری ماکزیمم تعداد سفارشات و جمع مقادیر نیز نمایش داده شود/
*/
-- جداول مورد نیاز: TSQLV4 database, Customers, Orders and OrderDetails tables
select c.custid , max(qty) as numorders , sum(qty) as totalqty
from sales.Customers as c
inner join sales.Orders as o
on c.custid=o.custid and country='USA'
inner join sales.OrderDetails as od
on o.orderid=od.orderid
group by c.custid
order by c.custid

--Desired output
custid      numorders   totalqty
----------- ----------- -----------
32          11          345
36          5           122
43          2           20
45          4           181
48          8           134
55          10          603
65          18          1383
71          31          4958
75          9           327
77          4           46
78          3           59
82          3           89
89          14          1063

(13 row(s) affected)

-- 4
/*
هر مشتری و تمام فروشهای آن نیز برگردانده شود. و همچنین شامل مشتری هایی باشد که هیچ فروشی ندارند.
*/
-- جداول مورد نیاز: TSQLV4 database, Customers and Orders tables

select c.custid , c.companyname , o.orderid ,o.orderdate
from Sales.Customers as c
left join sales.Orders as o
on c.custid=o.custid

-- Desired output
custid      companyname     orderid     orderdate
----------- --------------- ----------- -----------
85          Customer ENQZT  10248       2014-07-04 
79          Customer FAPSM  10249       2014-07-05 
34          Customer IBVRG  10250       2014-07-08 
84          Customer NRCSK  10251       2014-07-08 
...
73          Customer JMIKW  11074       2016-05-06 
68          Customer CCKOT  11075       2016-05-06 
9           Customer RTXGC  11076       2016-05-06 
65          Customer NYUHS  11077       2016-05-06 
22          Customer DTDMN  NULL        NULL
57          Customer WVAXS  NULL        NULL

(832 row(s) affected)

-- 5
/*
مشتریانی برگردانده شود که هیچ فروشی ندارند
*/
-- جداول مورد نیاز: TSQLV4 database, Customers and Orders tables

select c.custid , c.companyname
from Sales.Customers as c
left join sales.Orders as o
on c.custid=o.custid
where o.orderid is null

-- Desired output
custid      companyname
----------- ---------------
22          Customer DTDMN
57          Customer WVAXS

(2 row(s) affected)

-- 6
/*
 مشتریان با فروشهای آنها که در تاریخ Feb 12, 2016
 رخ داده است
*/
-- جداول مورد نیاز: TSQLV4 database, Customers and Orders tables

select c.custid , c.companyname , o.orderid ,o.orderdate
from Sales.Customers as c
inner join sales.Orders as o
on c.custid=o.custid and o.orderdate='20160212'

-- Desired output
custid      companyname     orderid     orderdate
----------- --------------- ----------- ----------
48          Customer DVFMB  10883       2016-02-12
45          Customer QXPPT  10884       2016-02-12
76          Customer SFOGW  10885       2016-02-12

(3 row(s) affected



