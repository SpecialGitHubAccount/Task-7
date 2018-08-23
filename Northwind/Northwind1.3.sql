use Northwind;

if Object_id('Region', 'U') is not null 
begin
exec sp_rename 
	@objname = N'[dbo].[Region]',
 	@newname = N'Regions';
end

select * from dbo.regions

go

if col_length('dbo.Customers', 'FoundationDate') is null
BEGIN
    alter table dbo.Customers
	add FoundationDate datetime
END
select * from Customers