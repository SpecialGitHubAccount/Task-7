-- 3.1
-- version 1.1
use Northwind;
if Object_id('CreditCards', 'U') is null 
begin
    create table CreditCards(
        CreditCardId int primary key identity(1,1) not null,
        ExpirationDate datetime default(null),
        CardHolderName varchar(200) not null,
		EmployeeId int unique not null,
        constraint FK_Employees_CreditCards foreign key (EmployeeId)
		references Employees(EmployeeID)
		on delete cascade
		on update cascade
        );
end;
go
select * from CreditCards