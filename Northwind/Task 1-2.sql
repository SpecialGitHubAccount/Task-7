-- 1.1
--  1.1.1
use Northwind

select OrderId, ShippedDate, ShipVia
from Orders
where ShippedDate >= '19980506' and ShipVia >= 2;

-- 1.1.2

select OrderId,  case when ShippedDate  is null then 'Not Shipped' end
from Orders
where ShippedDate is null;

-- 1.1.3

select OrderID as 'Order Number',
case when ShippedDate  is null then 'Not Shipped' end
from Orders
where ShippedDate > '19980506' or ShippedDate is null


-- 1.2
-- 1.2.1
select CompanyName, Country 
from Customers
where Country in ('USA', 'Canada')
order by CompanyName, Address
-- 1.2.2
select CompanyName, Country from Customers
where Country not in ('USA', 'Canada')
-- 1.2.3
select Country
from Customers
order by Country desc

-- 1.3
-- 1.3.1
select distinct OrderID
from [Order Details]
where Quantity between 3 and 10;
-- 1.3.2
select CustomerID, Country
from Customers
where Country between 'b' and 'h'
order by Country;
-- 1.3.3
select ContactName
from Customers
where Country like '[^b-h]%';

-- 1.4
--1.4.1
select ProductName
from Products
where ProductName like 'cho_olade';

--2.1

-- 2.1.1
select Sum(Quantity * UnitPrice * (1 - Discount)) as 'Totals'
from [Order Details];

-- 2.1.2
select Count(*) - Count(ShippedDate) as 'Not Shipped orders quantity'
from Orders;

-- 2.1.3
select Count(CustomerID) as 'Customers quantity'
from Orders;

-- 2.2
-- 2.2.1

select Year(OrderDate) as Year, Count(CustomerID) as Total
from Orders
group by Year(OrderDate);

--2.2.2
select 
	(select Concat(LastName, ' & ', FirstName)
	 from  Employees
	 where EmployeeID = O.EmployeeID) as Seller,
	Count(O.OrderID) as amount
from Orders as O
group by O.EmployeeID
order by amount desc;

-- 2.2.3
select EmployeeID, Count(CustomerID) as Customers
from Orders
where Year(OrderDate) = 1998
group by EmployeeID, CustomerID

-- 2.2.4
select o.EmployeeID, c.CustomerID
from Orders as O, Customers as C
where O.ShipCity = C.City
group by o.EmployeeID, c.CustomerID
having Count(o.EmployeeID) != 0 or Count (c.CustomerId) != 0

-- 2.2.5
select City, CustomerID
from Customers
group by City, CustomerID
order by City, CustomerID

-- 2.2.6
select EmployeeID, ReportsTo
from Employees
group by EmployeeID, ReportsTo

-- 2.3
-- 2.3.1
select c.CustomerID
from Customers C
join Region R
on c.Region = r.RegionDescription

-- 2.3.2
select c.CustomerID, Count(o.OrderID) as ordersCount
from Customers as C
left join Orders as O
on c.CustomerID = o.CustomerID 
group by c.CustomerID
order by ordersCount
-- 2.4
-- 2.4.1
select CompanyName
from Suppliers
where SupplierID in (select SupplierID from Products
					 where UnitsInStock = 0);

-- 2.4.2
select * 
from Employees e
where (select count(o.OrderID)
						from Orders o
						where o.EmployeeID = e.EmployeeID) > 150;

-- 2.4.3
select C.CustomerID 
from Customers as C
where not exists (select O.CustomerID
	   from Orders as O
	   where c.CustomerID = o.CustomerID);



-- 3.1
-- version 1.1
if Object_id('CreditCards', 'U') is not null 
begin
    create table CreditCards(
        CreditCardId int primary key identity(1,1) not null,
        ExpirationDate datetime default(null),
        CardHolderName varchar(200) not null,
		EmployeeId int unique not null,
        constraint FK_Employees_CreditCards foreign key(EmployeeId) 
		references Employees(EmployeeID)
		on delete cascade
		on update cascade
        );
end

-- version 1.3
if Object_id('Region', 'U') is not null 
begin
exec sp_rename 
	@objname = N'[dbo].[Region]',
 	@newname = N'Region ', 
           @objtype = N'U';
end