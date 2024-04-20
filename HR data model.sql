CREATE DATABASE EmployeeRecord
go
USE EmployeeRecord
go
CREATE SCHEMA People
go


CREATE TABLE People.manager
(	ManagerID int Primary Key,
	ManagerName nvarchar (250)
	)

CREATE TABLE People.emp
(
	EmployeeID int identity (1,1) primary key,
	FirstName NVarchar(250),
	LastName NVarchar(250),
	DateOfBirth date,
	Gender varchar(20),
	Nationality NVARCHAR(250),
	Address NVARCHAR(250),
	PhoneNumber int,
	Email nvarchar (50),
	NextofkinName nvarchar(250),
	NextofKinContactPhoneNumber int,
	HireDate date,
	EmploymentStatus varchar(50),
	JobTitle nvarchar(250),
	Department varchar (250),
	ManagerID int,
	WorkSchedule varchar(50),
	Salary decimal,
	PayGrade nvarchar(50),
	Overtime money,
	Allowances money 
	)

CREATE TABLE People.training
(	TrainingID int Primary Key,
	TrainingName nvarchar(250),
	TrainingType nvarchar(250),
	TrainingProvider nvarchar(250),
	TrainingDuration Time,
	TrainingCost money
	)

CREATE TABLE People.leave
( LeaveID int Primary Key,
	LeaveType varchar (50),
	LeaveBalance int,
	LeaveRequestDate date,
	LeaveApprovalStatus bit
)

CREATE TABLE People.PerformanceReview
(	ReviewID int Primary Key,
	ReviewDate date,
	ReviewerID int,
	ReviewType varchar,
	ReviewOutcome int

	)

CREATE TABLE People.engagement
(	EngagementID int Primary Key,
	EngagementDate date,
	BusinessPartnerID int,
	EngagementDescription text,
	EngagementOutcome text
	)

--Other HR entities can be added to this list to make it more comprehensive for analytics
--ERD was designed here in SQL server
--PK and FK was attributed during ERD design phase.
