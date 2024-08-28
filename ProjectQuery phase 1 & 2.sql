
---1.Create a database for a banking application called “Bank”

create database Bank

use bank


---2.Create all the tables mentioned in the database diagram

create table UserLogins
(UserLoginID smallint  primary key,UserName char(15) not null,UserPassword varchar(20) not null)

insert into UserLogins values
(1001,'mayababu','maya@2000'),
(1002,'subash123','abc1234'),
(1003,'kaith987','xyz123'),
(1004,'yaami21','sasdsdd'),
(1005,'xavier','123@abc')

select * from UserLogins

create table Login_Account
(UserLoginID smallint not null,AccountID int not null,
constraint FK1 foreign key (UserLoginID) references UserLogins(UserLoginID),
constraint FK2 foreign key (AccountID) references Account(AccountID))

insert into Login_Account values
(1003,1111),
(1002,1113),
(1001,1112),
(1004,1114),
(1005,1115)

select * from Login_Account

create table UserSecurityQuestions
(UserSecurityQuestionID tinyint primary key,UserSecurityQuestion varchar(50) not null)

insert into UserSecurityQuestions values
(111,'Name_of_your_bestfriend'),
(112,'Name_of_your_mother'),
(113,'bestman_in_your_marriage'),
(114,'Favourite_colour'),
(115,'Favourite_movie')

select * from UserSecurityQuestions

create table UserSecurityAnswers
(UserLoginID smallint primary key,UserSecurityQuestionAnswer varchar(25) not null,UserSecurityQuestionID tinyint not null,
constraint FK17 foreign key (UserLoginID) references UserLogins(UserLoginID),
constraint FK4 foreign key (UserSecurityQuestionID) references UserSecurityQuestions(UserSecurityQuestionID))

insert into UserSecurityAnswers values
(1005,'Blue',114),
(1003,'Gita',112),
(1002,'Rose',111),
(1001,'Raj',113),
(1004,'Spiderman',115)

select * from UserSecurityAnswers


create table Account
(AccountID int primary key,CurrentBalance money not null, AccountTypeID tinyint not null,AccountStatusTypeID tinyint not null,
InterestSavingsRateID tinyint not null,
constraint FK3 foreign key (AccountTypeID) references AccountType(AccountTypeID),
constraint FK5 foreign key (AccountStatusTypeID) references AccountStatusType(AccountStatusTypeID),
constraint FK6 foreign key (InterestSavingsRateID) references SavingsInterestRates(InterestSavingsRateID))
go

insert into Account values
(1111,5200,01,01,102),
(1112,3400,02,02,101),
(1113,2860,02,01,104),
(1114,9460,02,01,105),
(1115,7400,02,02,101)


select * from Account


create table Customer
(CustomerID int primary key,CustomerAddress1 varchar(30)not null,CustomerAddress2 varchar(30),CustomerFirstName varchar(30)not null,
CustomerLastName varchar(30)not null,CustomerMiddleInitial char(1),city varchar(20)not null,State char(2)not null,
Zipcode char(10)not null,Email nvarchar(50)not null,Homephone char(10),Cellphone char(10)not null,Workphone char(10),
SSN char(9)not null,UserLoginID smallint not null,
constraint FK7 foreign key (UserLoginID) references UserLogins(UserLoginID))

insert into Customer values
(100001,'Sunrise_Square',null,'Maya','Babu',null,'Scarborough','ON','M1B1R3','maya@gmail.com',null,1234567890,null,14728369,1001),
(100002,'Shropshire_Drive',null,'John','Samuel','G','Oshawa','ON','M1P1Y3','john@gmail.com',null,9876543210,null,123586974,1002),
(100003,'parkway_ave',null,'sony','sanjay',null,'Kingston','NS','Z1YN7K','sony@gmail.com',null,6476476470,null,543256987,1003),
(100004,'kitty_drive',null,'Sam','Sung','H','Missisauga','ON','M8H7Y5','sam@gmail.com',null,4374374375,null,111222333,1004),
(100005,'mersal','avenue','Sayak','Chandra',null,'Barry','ON','J5O6G3','sai@gmail.com',null,6474376473,null,333222111,1005)

select * from Customer


create table TransactionLog
(TransactionID int primary key,TransactionTypeID tinyint not null,TransactionDate datetime not null,
TransactionAmount money not null,NewBalance money not null,
AccountID int not null,CustomerID int not null,EmployeeID int not null,UserLoginID smallint not null,
constraint FK8 foreign key (TransactionTypeID ) references TransactionType(TransactionTypeID),
constraint FK9 foreign key (AccountID) references Account(AccountID),
constraint FK10 foreign key (CustomerID) references customer(CustomerID),
constraint FK11 foreign key (EmployeeID) references Employee(EmployeeID),
constraint FK12 foreign key (UserLoginID) references UserLogins(UserLoginID)) 

insert into TransactionLog values
(01,0123,'2023-10-10 10:15:00',1260,2360,1113,100001,1010,1003),
(02,0124,'2023-10-11 13:20:00',3254,2640,1111,100002,1011,1001),
(03,0125,'2023-10-12 14:00:00',600.56,1300,1114,100003,1013,1002),
(04,0126,'2023-10-13 12:45:00',233.21,4230.15,1115,100004,1014,1004),
(05,0127,'2023-10-14 11:30:00',1630,2310,1112,100005,1012,1005)


select * from TransactionLog

create table Employee
(EmployeeID int primary key,EmployeeFirstName varchar(20) not null,EmployeelastName varchar(25) not null,EmployeeMiddleInitial char(1),
EmploeeIsManager bit)

insert into Employee values
(1010,'Joseph','Buell','K',0),
(1011,'Kayla','Buell','M',1),
(1012,'Maryam','Raza','N',0),
(1013,'George','Jackson',null,1),
(1014,'Mustafa','Rahman','A',0)

select * from Employee


create table LoginErrorLog
(ErrorLogID int primary key,ErrorTime datetime not null,FailedTransactionXML xml)

Insert into LoginErrorLog Values 
('1','2023-07-01 10:10:10','<?xml version="1.0" encoding="utf-8"?><Error>
<UserLoginID>3</UserLoginID><Code>1</Code><Description>Insufficient Funds </Description>
<Message> You do not have sufficient funds in your account. </Message></Error>'),
('2','2023-07-01 15:10:10','<?xml version="1.0" encoding="utf-8"?><Error><UserLoginID>1</UserLoginID><Code>1</Code> 
<Description>Insufficient Funds </Description><Message> You do not have sufficient funds in your account. </Message></Error>'),
('3','2023-07-01 20:10:10','<?xml version="1.0" encoding="utf-8"?><Error><UserLoginID>3</UserLoginID><Code>1</Code>
<Description>Insufficient Funds </Description><Message> You do not have sufficient funds in your account. </Message></Error>'),
('4','2023-07-03 15:10:10','<?xml version="1.0" encoding="utf-8"?><Error><UserLoginID>3</UserLoginID><Code>8</Code>
<Description>Expired Card </Description><Message> Your card has expired. Apply for a new one. </Message></Error>');

select * from LoginErrorLog

create table SavingsInterestRates
(InterestSavingsRateID tinyint primary key,InterestRateValue numeric(9,2) not null,InterestRateDescription varchar(30))

insert into SavingsInterestRates values
(101,0.11,'LongTermdeposit_10years'),
(102,0.17,'LongTermDeposit_8years'),
(103,0.18,'LongTermDeposit_12years'),
(104,0.22,'LongTermDeposit_10years'),
(105,0.07,'LongTermDeposit_8years')

select * from SavingsInterestRates

create table TransactionType
(TransactionTypeID tinyint primary key,TransactionTypeName char(10) not null,TransactionTypeDescription varchar(50),
TransactionFeeAmount smallmoney)

insert into TransactionType values
(0123,'withdrawal','Amount Deposited Successful',4.5),
(0124,'Deposit','Amount Deposited Successful',3.5),
(0125,'Transfer','Amount Deposited Successful',1.5),
(0126,'Deposit','Amount Deposited Successful',2.3),
(0127,'Deposit','Amount Deposited Successful',4.0)

select * from TransactionType

create table OverDraftLog
(AccountID int primary key,OverDraftDate datetime,OverDraftAmount money,OverDraftTransactionXML xml,
constraint FK16 foreign key (AccountID) references Account(AccountID))

insert into OverDraftLog values
(1111, '2023-10-14', 50.00, '<transaction><description>Overdraft charge</description><amount>50.00</amount></transaction>'),
(1112, '2023-10-15', 75.50, '<transaction><description>Overdraft fee</description><amount>75.50</amount></transaction>'),
(1113, '2023-10-16', 30.25, '<transaction><description>Overdraft penalty</description><amount>30.25</amount></transaction>'),
(1114, '2023-10-17', 100.75, '<transaction><description>Overdraft fee</description><amount>100.75</amount></transaction>'),
(1115, '2023-10-18', 45.60, '<transaction><description>Overdraft charge</description><amount>45.60</amount></transaction>')

select * from OverDraftLog

create table FailedtransactionLog
(FailedTransactionID int primary key,FailedTransactionErrorTypeID tinyint,FailedTransactionXML xml,FailedTransactionErrorTime datetime,
constraint FK13 foreign key (FailedTransactionErrorTypeID) references FailedTransactionErrorType(FailedTransactionErrorTypeID))

insert into FailedtransactionLog values
(1, 005, '<transaction><description>Failed charge</description><amount>50.00</amount></transaction>', '2023-10-14 12:30:00'),
(2, 006, '<transaction><description>Failed fee</description><amount>75.50</amount></transaction>', '2023-10-15 14:45:00'),
(3, 007, '<transaction><description>Failed penalty</description><amount>30.25</amount></transaction>', '2023-10-16 11:15:00'),
(4, 008, '<transaction><description>Failed fee</description><amount>100.75</amount></transaction>', '2023-10-17 16:20:00'),
(5, 009, '<transaction><description>Failed charge</description><amount>45.60</amount></transaction>', '2023-10-18 10:00:00')

select * from FailedTransactionLog

create table FailedTransactionErrorType
(FailedTransactionErrorTypeID tinyint primary key,FailedTransactionDescription varchar(50))

insert into FailedTransactionErrorType values
(005,'InsufficientFund'),
(006,'ExpiredCard'),
(007,'WrongPin'),
(008,'DailyLimitIsOver'),
(009,'InvalidCVV')

select * from FailedTransactionErrortype



create table AccountStatusType
(AccountStatusTypeID tinyint primary key not null,AccountStatusDescription varchar(30) not null)

insert into AccountStatusType values
(01,'Active'),
(02,'Inactive')

select * from AccountStatusType

create table AccountType
(AccountTypeID tinyint primary key,AccountTypeDescription varchar(30) not null)

insert into AccountType values
(01,'Savings'),
(02,'Chequing')

select * from AccountType

create table Customer_Account
(AccountID int primary key,CustomerID int not null,
constraint FK14 foreign key (AccountID) references Account(AccountID),
constraint FK15 foreign key (CustomerID) references Customer(CustomerID))

insert into Customer_Account values
(1115,100003),
(1113,100002),
(1112,100001),
(1111,100004),
(1114,100005)

Select * from Customer_Account

select * from Account
select * from AccountStatusType
select * from AccountType
select * from Customer
select * from Customer_Account
select * from Employee
select * from FailedTransactionErrorType
select * from FailedtransactionLog
select * from Login_Account
select * from LoginErrorLog
select * from OverDraftLog
select * from SavingsInterestRates
select * from TransactionLog
select * from TransactionType
select * from UserLogins
select * from UserSecurityAnswers
select * from UserSecurityQuestions



--PHASE II

1.--Create a view to get all customers with checking accounts from ON province.

Create view ONChequing
AS
	SELECT c.CustomerId, c.CustomerFirstName, c.CustomerLastName, c.State, at.AccountTypeDescription
FROM Customer c
JOIN Customer_Account ca 
ON ca.CustomerID = c.customerid
join Account a
on a.AccountID = ca.AccountID
join AccountType at
on at.AccountTypeID = a.AccountTypeID
Where at.AccountTypeDescription = 'Chequing' and State = 'ON'

Select * from ONChequing

--2.Create a view to get all customers with a total account balance (including interest rate) greater than 5000. 

CREATE VIEW sp_Customers_With_Balance_Above_5000 
AS
SELECT c.CustomerFirstName, SUM(a.CurrentBalance + (a.CurrentBalance * s.interestRatevalue)) AS TotalAccountBalance 
From Customer c
join Customer_Account ca
ON ca.CustomerID = c.CustomerID
join Account a
ON a.AccountID = ca.AccountID
join SavingsInterestRates s
ON s.InterestSavingsRateID = a.InterestSavingsRateID
GROUP BY c.CustomerFirstName
HAVING SUM(a.CurrentBalance + (a.CurrentBalance * s.InterestRateValue)) >5000

select * from sp_Customers_With_Balance_Above_5000

--3.Create a view to get counts of checking and savings accounts by customer.

Create view AccountsCount
as
select c.CustomerFirstName, at.AccountTypeDescription, count(*) as TotalAccountTypes
from Customer c
join Customer_Account ca
on ca.CustomerID = c.CustomerID
join Account a
on a.AccountID = ca.AccountID
join AccountType at
on at.AccountTypeID = a.AccountTypeID
group by c.CustomerFirstName, at.AccountTypeDescription

select * from AccountsCount

---4.Create a view to get any particular user’s login and password using AccountId.

create view UserLoginAndPassword
as
Select distinct ul.UserLoginID, ul.UserName, ul.UserPassword
from UserLogins ul
join Login_Account la
on ul.UserLoginID = la.UserLoginID
Join Account a
on a.AccountID = la.AccountID
where la.AccountID = '1112'

select * from UserLoginAndPassword

--5.Create a view to get all customers’ overdraft amounts.

create view CustomerOverDraft
as
select distinct c.CustomerFirstName, o.OverdraftAmount
from OverDraftLog o
join Customer_Account ca
on ca.AccountID = o.AccountID
join Customer c
on c.CustomerID = ca.CustomerID
go

select * from CustomerOverDraft

--6.Create a stored procedure to add “User_” as a prefix to everyone’s login

drop proc AddUserPrefixtoLogin

create procedure AddUserPrefixtoLogin
as
begin
 update UserLogins 
 set UserName ='User_' + UserName
 end

execute AddUserPrefixtoLogin

select * from UserLogins

--7.Create a stored procedure that accepts AccountId as a parameter and returns the customer’s full name


IF EXISTS (SELECT * FROM sys.procedures WHERE NAME='spFullNameFromAccountId2')
DROP PROC spFullNameFromAccountId2
go
create proc spFullNameFromAccountId      
            @AccountID int,                
			@Fullname nvarchar(100) output 
as
begin
  if (@AccountID in (select AccountID from Customer_Account))
		begin
	  			Select @FullName= c.CustomerFirstName+' '+c.CustomerMiddleInitial+' '+c.CustomerLastName
				from Customer c
				join Customer_Account ca
				on ca.CustomerID=c.CustomerID
				where ca.AccountID=@AccountID;
                set @Fullname= @FullName
		end
  else
		begin
				print 'There is no Customer with  Account Id= '+CONVERT(varchar(12), @AccountID )
		end
end

--Executing for invalid account id
Declare @FullName nvarchar(100)
exec spFullNameFromAccountId 1116, @FullName out
Print ' Full name is '+ @FullName
Declare @FullName nvarchar(100)
exec spFullNameFromAccountId 1112, @FullName out
Print ' Full name is '+ @FullName



---8.Create a stored procedure that returns error logs inserted in the last 24 hours.

DROP PROCEDURE GetErrorLogsLast24Hours
GO


Insert into LoginErrorLog Values 
('5','2023-10-29 12:10:10','<?xml version="1.0" encoding="utf-8"?><Error>
<UserLoginID>3</UserLoginID><Code>1</Code><Description>Insufficient Funds </Description>
<Message> You do not have sufficient funds in your account. </Message></Error>')


Insert into LoginErrorLog values
('6','2023-10-29 09:10:10','<?xml version="1.0" encoding="utf-8"?><Error>
<UserLoginID>3</UserLoginID><Code>1</Code><Description>Insufficient Funds </Description>
<Message> You do not have sufficient funds in your account. </Message></Error>')


CREATE PROCEDURE GetErrorLogsLast24Hours
AS
BEGIN
    SELECT ErrorLogID , ErrorTime, FailedtransactionXML
    FROM LoginErrorLog
    WHERE ErrorTime BETWEEN DATEADD(hh, -24, GETDATE()) AND GETDATE()
END;
Exec GetErrorLogsLast24Hours

--9.Create a stored procedure that takes a deposit as a parameter and updates the
--CurrentBalance value for that particular account.

Drop proc UpdateAccountBalance

CREATE PROCEDURE UpdateAccountBalance
    @AccountId INT,
    @DepositAmount DECIMAL(10, 2)
AS
BEGIN
    DECLARE @CurrentBalance DECIMAL(10, 2);
	    -- Get the current balance of the account
    SELECT @CurrentBalance = CurrentBalance
    FROM Account
    WHERE AccountId = @AccountId

    -- Update the current balance by adding the deposit amount
    SET @CurrentBalance = @CurrentBalance + @DepositAmount

    -- Update the CurrentBalance in the Accounts table
    UPDATE Account
    SET CurrentBalance = CurrentBalance+ @DepositAmount
    WHERE AccountId = @AccountId

    -- Return the updated CurrentBalance
    SELECT @AccountId as AccountID, @CurrentBalance AS UpdatedBalance;
END;

	declare @AccountID int
	declare @DepositAmount decimal(10,2)
	set @AccountID = 1111
	set @DepositAmount = 1000
exec UpdateAccountBalance @AccountID,@DepositAmount

--10.Create a stored procedure that takes a withdrawal amount as a parameter and updates

Drop proc CBalanceAfterWithdrawal

CREATE PROCEDURE CBalanceAfterWithdrawal
    @AccountId INT,@withdrawal DECIMAL(10, 2)
AS
BEGIN
    DECLARE @CurrentBalance DECIMAL(10, 2);
	    -- Get the current balance of the account
    SELECT @CurrentBalance = CurrentBalance
    FROM Account
    WHERE AccountId = @AccountId

    -- Update the current balance by deducting the withdrawal amount
    SET @CurrentBalance = @CurrentBalance - @withdrawal

    -- Update the CurrentBalance in the Accounts table
    UPDATE Account
    SET CurrentBalance = CurrentBalance - @withdrawal
    WHERE AccountId = @AccountId

    -- Return the updated CurrentBalance
    SELECT @AccountId as AccountID, @CurrentBalance AS UpdatedBalance;
END;

	declare @AccountID int
	declare @withdrawal decimal(10,2)
	set @AccountID = 1111
	set @withdrawal = 1000
exec UpdateAccountBalance @AccountID,@withdrawal