Use master;
go

drop database if exists PRS;
go

create database PRS;
go

Use PRS;
go

create table Users
(Id Int not null primary key identity(1,1),
UserName varchar(20) not null unique,
Password varchar(10) not null,
FirstName varchar(20) not null,
LastName varchar(20) not null,
PhoneNumber varchar(12) not null, 
Email varchar(75) not null,
IsReviewer bit not null default 0,
IsAdmin bit not null default 0) ;

insert users
(username, password, FirstName, LastName, PhoneNumber, Email)
Values
('J.doe', 'password', 'John', 'Doe', '513-555-1111', 'j.doe@email.com'),
('Jane.doe', 'password', 'Jane', 'Doe', '513-555-2222', 'jane.doe@email.com'),
('john.smith', 'password', 'John', 'Smith', '513-555-3333', 'john.smith@email.com'),
('mary.jane', 'password', 'Mary', 'Jane', '513-555-4444', 'mary.jane@email.com');

create table Vendors
(Id Int not null primary key identity(1,1),
Code varchar(10) not null unique,
Name varchar(255) not null,
Address varchar(255) not null,
City varchar(255) not null,
State varchar(255) not null, 
Zip varchar(5) not null,
PhoneNumber varchar(12) not null,
Email varchar(100) not null);

insert vendors
(Code, Name, address, city, state, zip, PhoneNumber, Email)
Values
('A1', 'ABC Corp', '1234 steetname st', 'Erlanger', 'Kentucky', '41018', '859-555-1111', 'abc.corp@email.com'),
('A2', '123 Co.', '1234 Bedrock Ct', 'Florence', 'Kentucky', '41042', '859-555-2222', '123.co@email.com'),
('A3', 'Big Inc', '9876 Corp lane', 'Independence', 'Kentucky', '41051', '859-555-3333', 'big.inc@email.com'),
('A4', 'Store LLC', '4321 Company st', 'Covington', 'Kentucky', '41014', '859-555-4444', 'store.llc@email.com');

create table Products
(Id Int not null primary key identity(1,1),
VendorId int not null foreign key references vendors(Id),
PartNumber varchar(50) not null unique,
Name varchar(150) not null,
Price decimal(10,2) not null,
Unit varchar(255) null, 
PhotoPath varchar(255) null);

insert Products
(VendorId, partnumber, name, price, unit)
Values
(1, '123456', 'Case of Hard Drink', 19.99, '12'),
(2, '123abc', 'Paper', 20.00, '1000'),
(3, '98765', 'Couch1', 1500.00, '1'),
(4, '56789', 'Jeans', 49.00, '1');

create table Requests
(Id int not null primary key identity(1,1),
UserId int not null foreign key references users(id),
Description varchar(100) not null,
Justification varchar(255) not null,
DateNeeded datetime not null default getdate(),
DeliveryMode varchar(25) not null,
Status varchar(20) not null default 'NEW',
Total decimal(10,2) not null default 0,
SubmittedDate datetime not null default getdate(),
ReasonForRejection varchar(100) null);

insert Requests
(UserId, Description, Justification, DeliveryMode, Total)
Values
(1, 'purchase order for customer', 'to fulfill order', 'Ground', 19.99),
(2, 'purchase order for customer', 'to fulfill order', 'Air', 80.00),
(3, 'purchase order for customer', 'to fulfill order', 'Ground', 1500.00),
(4, 'purchase order for customer', 'to fulfill order', 'Air', 99.98);

create table LineItem
(Id int not null primary key identity(1,1),
RequestId int not null foreign key references requests(id),
ProductId int not null foreign key references Products(id),
Quantity int not null);

insert LineItem
(RequestId, ProductId, Quantity)
Values
(1, 1, 1),
(2, 2, 4),
(3, 3, 1),
(4, 4, 2);