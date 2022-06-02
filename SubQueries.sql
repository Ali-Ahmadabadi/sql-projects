
-- 1 
/*
کدی بنویسید که تمام فروش های مربوط به آخرین روز فعالیت در جدول فروش را نمایش دهد.
*/
-- Tables involved: TSQLV4 database, Orders table

select orderid,orderdate,custid,empid
from sales.Orders
where orderdate=(select max(orderdate) from Sales.Orders)

--Desired output
orderid     orderdate   custid      empid
----------- ----------- ----------- -----------
11077       2016-05-06  65          1
11076       2016-05-06  9           4
11075       2016-05-06  68          8
11074       2016-05-06  73          7

(4 row(s) affected)


-- 2
/*
لیست فروشنده هایی  که فروش در روزMay 1st, 2016 
یا بعد از آن نداشتند
*/
-- Tables involved: TSQLV4 database, Employees and Orders tables

select e.empid,firstname,lastname
from hr.Employees as e
left join Sales.Orders as o
on e.empid=o.empid and orderdate>='2016-05-01'
where orderid is null

-- Desired output:
empid       FirstName  lastname
----------- ---------- --------------------
3           Judy       Lew
5           Sven       Mortensen
6           Paul       Suurs
9           Patricia   Doyle

(4 row(s) affected)

-- 3
/*
لیست کشورهایی که مشتریان ما در آنجا هستند ولی کارمندان در آنجا نیستند
*/
-- Tables involved: TSQLV4 database, Customers and Employees tables

select distinct(c.country)
from Sales.Customers as c
left join HR.Employees as e
on c.country=e.country
where e.country is null

-- Desired output:
country
---------------
Argentina
Austria
Belgium
Brazil
Canada
Denmark
Finland
France
Germany
Ireland
Italy
Mexico
Norway
Poland
Portugal
Spain
Sweden
Switzerland
Venezuela

(19 row(s) affected)

-- 4
/*
برای هر مشتری تمام فروشهای مربوط به آن مشتری در آخرین روزی که خرید انجام داده است.
*/
-- Tables involved: TSQLV4 database, Orders table

select custid,orderid,orderdate,empid
from Sales.Orders as o1
where o1.orderid=
(select max(o2.orderid) from Sales.Orders as o2 where o2.custid=o1.custid)

-- Desired output:
custid      orderid     orderdate   empid
----------- ----------- ----------- -----------
1           11011       2016-04-09  3
2           10926       2016-03-04  4
3           10856       2016-01-28  3
4           11016       2016-04-10  9
5           10924       2016-03-04  3
...
87          11025       2016-04-15  6
88          10935       2016-03-09  4
89          11066       2016-05-01  7
90          11005       2016-04-07  2
91          11044       2016-04-23  4

(90 row(s) affected)

-- 5
/*
لیست مشتریانی که در سال 2015 خرید داشتند نه در سال 2016
*/
-- Tables involved: TSQLV4 database, Customers and Orders tables

select c.custid,companyname
from sales.Customers as c
where c.custid in
(select custid from sales.Orders as o where year(orderdate)=2015) and c.custid not in 
(select custid from sales.Orders as o where year(orderdate)=2016)

select * from sales.Orders
select * from sales.Customers

-- Desired output:
custid      companyname
----------- ----------------------------------------
21          Customer KIDPX
23          Customer WVFAF
33          Customer FVXPQ
36          Customer LVJSO
43          Customer UISOJ
51          Customer PVDZC
85          Customer ENQZT

(7 row(s) affected)



-- 9
/*
تفاوت بین IN و Exists را شرح دهید
*/


--exit be surate yek correlated query amal mikonad vali in baraye barresi ye list mibashad

