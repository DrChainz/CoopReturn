--------------------------------------------------------------------------------------------------
--  This almost ought to be a type -
--  thou for now we are going to create a table
--------------------------------------------------------------------------------------------------
USE DA;
GO

-------------
-- Defaults
-------------
/*
CREATE DEFAULT [legend].[No] AS 'N';
CREATE DEFAULT [legend].[Phone] AS CHAR(10);
CREATE DEFAULT [legend].[Unknown] AS 'U';
CREATE DEFAULT [legend].[ContactType_PersonDefault] AS 'Person';		-- not certain how using need to look into again
CREATE DEFAULT [legend].[Zero] AS 0;
*/

-------------
-- Rules
-------------
/*
CREATE RULE [legend].[ContactType_Domain] AS @ContactType in ('Biz', 'Person');

CREATE RULE [legend].[PhoneFormat] AS @Phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';

CREATE RULE [legend].[SalesRangeDomain] AS @SalesRange IN ('UNKNOWN','LESS THAN $500,000','$500,000 TO $1 MILLION','$1 TO 2.5 MILLION','$2.5 TO 5 MILLION','$5 TO 10 MILLION',
'$10 TO 20 MILLION','$20 TO 50 MILLION','$50 TO 100 MILLION','$100 TO 500 MILLION','$500 MILLION TO $1 BILLION','OVER $1 BILLION');

CREATE RULE [legend].[EmployeeRangeDomain] AS @EmployeeRange IN ('UNKNOWN','1 to 4','5 to 9','10 to 19','20 to 49','50 to 99','100 to 249',
																 '250 to 499','500 to 999','Over 1000','1,000 to 4,999','5,000 to 9,999','Over 10,000');
CREATE RULE [legend].[YesNoDomain] AS @Val IN ('N','Y');

CREATE RULE [legend].[YesNoUnknownDomain] AS @YesNoUnknown in ('U', 'N', 'Y');

CREATE RULE [legend].[EmailFormat] AS @Email LIKE '%@%.%';

*/

-------------
-- Types
-------------
/*
CREATE TYPE [legend].[ContactType] FROM [varchar](10) NOT NULL;
CREATE TYPE [legend].[EmployeeRange] FROM [varchar](20) NOT NULL;
CREATE TYPE [legend].[Phone] FROM [char](10) NULL;
CREATE TYPE [legend].[SalesRange] FROM [varchar](30) NOT NULL;
CREATE TYPE [legend].[SmallIntZeroDefault] FROM [smallint] NOT NULL;
CREATE TYPE [legend].[YesNoUnknown] FROM [char](1) NOT NULL;
CREATE TYPE [legend].[Email] FROM [varchar](50) NULL;
CREATE TYPE [legend].[IP] FROM [varchar](15) NULL;
*/

------------------------------------
-- Bind all the rules to the Types
------------------------------------
/*
sp_bindrule '[legend].[ContactType_Domain]', '[legend].[ContactType]';
sp_bindrule '[legend].[EmployeeRangeDomain]', '[legend].[EmployeeRange]';
sp_bindrule '[legend].[PhoneFormat]', '[legend].[Phone]';
sp_bindrule '[legend].[SalesRangeDomain]', '[legend].[SalesRange]';
sp_bindrule '[legend].[YesNoUnknownDomain]', '[legend].[YesNoUnknown]';

sp_bindrule '[legend].[EmailFormat]', '[legend].[Email]';
*/

------------------------------------
-- Bind all the defaults to the Types
------------------------------------
/*
sp_bindefault 'legend.ContactType_PersonDefault', '[legend].[ContactType]';
sp_bindefault '[legend].[Zero]', '[legend].[SmallIntZeroDefault]';
sp_bindefault 'legend.UnknownDefault', '[legend].[YesNoUnknown]';
*/


/*
create table legend.DataSetTypes
(
	DataSetType		varchar(20)		NOT NULL	UNIQUE	-- Enterprise, Biz, Person (initial values)
);
*/


-- sp_bindefault '[legend].[No]', '[legend].[YesNo]';


-- CREATE TYPE [legend].[Phone] FROM char(10) NULL;

-- CREATE TYPE [legend].[YesNo] FROM char(1) NULL;

-- CREATE RULE [legend].[YesNoDomain] AS @Val IN ('N','Y');

-- CREATE TYPE [legend].[Phone] FROM char(10) NULL;

-- CREATE RULE [legend].[PhoneFormat] AS @Phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';

-- sp_bindrule '[legend].[PhoneFormat]', '[legend].[Phone]';

-- CREATE TYPE [legend].[SalesRange] FROM varchar(30) NOT NULL;
-- CREATE TYPE [legend].[EmployeeRange] FROM varchar(20) NOT NULL;

/*
CREATE RULE [legend].[EmployeeRangeDomain] AS @EmployeeRange IN ('UNKNOWN','1 to 4','5 to 9','10 to 19','20 to 49','50 to 99','100 to 249',
																 '250 to 499','500 to 999','Over 1000','1,000 to 4,999','5,000 to 9,999','Over 10,000');

CREATE RULE [legend].[EmployeeRangeDomain] AS @EmployeeRange IN ('


select * from legend.EmployeeRange order by Idx


-- sp_bindrule '[legend].[EmployeeRangeDomain]', '[legend].[EmployeeRange]';


-- CREATE DEFAULT [legend].[No] AS 'N';

-- CREATE DEFAULT [legend].[Zero] AS 0;
-- CREATE TYPE [legend].[SmallIntZeroDefault] FROM smallint NOT NULL;

-- sp_bindefault '[legend].[Zero]','[legend].[SmallIntZeroDefault]';

select * from legend.SalesRange


select max(len(SalesRange)) from legend.SalesRange

-- drop table legend.DataSetTypeRows;

/***********************************************************************
 ** Now this is where we're at
 ***********************************************************************/
DROP TABLE [legend].[DataSet];
DROP TABLE [legend].[DataSetClass];
-- DROP TABLE [legend].[DataSetTypeRows];



-----------------
-- DataSetTypes
-----------------
CREATE TABLE [legend].[DataSetClass]
(
	[DataSetClass] [varchar](20) NOT NULL,
UNIQUE NONCLUSTERED 
(
	[DataSetClass] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];
 GO

INSERT [legend].[DataSetClass] (DataSetClass)
SELECT 'Enterprise' union
SELECT 'Business' union
SELECT 'Person' union
SELECT 'List'
;

--SELECT 'PersonEmail' union
--SELECT 'PersonPhone'

DROP TABLE [legend].[DataSetTypeRows];
 GO

DROP TABLE [legend].[DataSet];
 GO

CREATE TABLE [legend].[DataSet]
(
	DataSet			varchar(30)						NOT NULL	UNIQUE,
	DataSetClass	varchar(20)						NOT NULL,
	FOREIGN KEY (DataSetClass) REFERENCES [legend].[DataSetClass](DataSetClass)
) ON [PRIMARY];
 GO
 

CREATE TABLE [legend].[DataSetColumns]
(
	SNum			int								NOT NULL IDENTITY(1,1),
	DataSet			varchar(30)						NOT NULL,
	ColumnIdx		smallint						NULL,
	ColumnName		varchar(50)						NOT NULL,
	DataType		varchar(30)						NOT NULL,
	Length			[legend].[SmallIntZeroDefault]	NOT NULL,
	AllowNULL		[legend].[YesNo]				NOT NULL,
	ForeignKey		varchar(50)						NULL

	PRIMARY KEY (SNum),
	FOREIGN KEY (DataSet) REFERENCES [legend].[DataSet](DataSet)
) ON [PRIMARY];
 GO



select * from [legend].[DataSet];

select * from [legend].[DataSetColumns]

INSERT [legend].[DataSet] VALUES ('Enterprise','Enterprise');
DELETE [legend].[DataSetColumns] WHERE DataSet = 'Enterprise';
----------------------------------------------------------------------------------
-- Enterprise Table
----------------------------------------------------------------------------------
INSERT [legend].[DataSetColumns] (DataSet, ColumnIdx, ColumnName, DataType, Length, AllowNULL)
SELECT 'Enterprise',  0, 'EnterpriseSNum', 'varchar', 50, 'N' union
SELECT 'Enterprise',  1, 'EnterpriseName', 'varchar', 50, 'N' union
SELECT 'Enterprise',  2, 'FirstName', 'varchar', 30, 'Y' union
SELECT 'Enterprise',  3, 'LastName', 'varchar', 30, 'Y' union
SELECT 'Enterprise',  4, 'Title', 'varchar', 10, 'Y' union
SELECT 'Enterprise',  5, 'Suffix', 'varchar', 10, 'Y' union
SELECT 'Enterprise',  6, 'Address', 'varchar', 50, 'Y' union
SELECT 'Enterprise',  7, 'City', 'varchar', 30, 'Y' union
SELECT 'Enterprise',  8, 'State', 'char', 2, 'Y' union
SELECT 'Enterprise',  9, 'Zip', 'char', 5, 'Y' union
SELECT 'Enterprise', 10, 'Zip4', 'char', 4, 'Y' union
SELECT 'Enterprise', 11, 'Phone', 'Phone', 10, 'Y' union
SELECT 'Enterprise', 12, 'Fax', 'Phone', 10, 'Y' union
SELECT 'Enterprise', 13, 'Ext', 'varchar', 10, 'Y' union
SELECT 'Enterprise', 14, 'Email', '[legend].[Email]', 0, 'Y' union	-- length doesn't matter here as using defined type
SELECT 'Enterprise', 15, 'SalesRange', '[legend].[SalesRange]', 30, 'N' union
SELECT 'Enterprise', 16, 'EmployeeRange', '[legend].[EmployeeRange]', 30, 'N' -- union
;

SELECT * FROM [legend].[DataSetColumns] WHERE DataSet = 'Enterprise';

INSERT [legend].[DataSet] VALUES ('Business','Business');
DELETE [legend].[DataSetColumns] WHERE DataSet = 'Business';
----------------------------------------------------------------------------------
-- Biz Table
----------------------------------------------------------------------------------
INSERT [legend].[DataSetColumns] (DataSet, ColumnIdx, ColumnName, DataType, Length, AllowNULL)
SELECT 'Business', 0, 'BusinessSNum', 'int', 0, 'N' union
SELECT 'Business', 1, 'BusinessName', 'varchar', 50, 'N' union
SELECT 'Business', 2, 'FirstName', 'varchar', 30, 'Y' union
SELECT 'Business', 3, 'LastName', 'varchar', 30, 'Y' union
SELECT 'Business', 4, 'Title', 'varchar', 10, 'Y' union
SELECT 'Business', 5, 'Suffix', 'varchar', 10, 'Y' union
SELECT 'Business', 6, 'Address', 'varchar', 50, 'Y' union
SELECT 'Business', 7, 'City', 'varchar', 30, 'Y' union
SELECT 'Business', 8, 'State', 'char', 2, 'Y' union
SELECT 'Business', 9, 'Zip', 'char', 5, 'Y' union
SELECT 'Business', 10, 'Zip4', 'char', 4, 'Y' union
SELECT 'Business', 11, 'Phone', 'Phone', 10, 'Y' union
SELECT 'Business', 12, 'Fax', 'Phone', 10, 'Y' union
SELECT 'Business', 13, 'Ext', 'varchar', 10, 'Y' union
SELECT 'Business', 14, 'Email', '[legend].[Email]', 0, 'Y' union
SELECT 'Business', 15, 'SalesRange', '[legend].[SalesRange]', 30, 'N' union
SELECT 'Business', 16, 'EmployeeRange', '[legend].[EmployeeRange]', 30, 'N'
;

SELECT * FROM [legend].[DataSetColumns] WHERE DataSet = 'Business';

----------------------------------------------------------------------------------
-- Enterprises have one or more biz
----------------------------------------------------------------------------------
INSERT [legend].[DataSet] VALUES ('EnterpriseBusiness','Enterprise');
DELETE [legend].[DataSetColumns] WHERE DataSet = 'EnterpriseBusiness';

INSERT [legend].[DataSetColumns] (DataSet, ColumnIdx, ColumnName, DataType, Length, AllowNULL, ForeignKey)
SELECT 'EnterpriseBusiness',  0, 'EnterpriseSNum', 'int', 0, 'N', '[Enterprise].[EnterpriseSNum]' union
SELECT 'EnterpriseBusiness',  1, 'BusinessSNum', 'int', 0, 'N', '[Business].[BusinessSNum]'

-- select * from legend.DataSetColumns

INSERT [legend].[DataSet] VALUES ('Person','Person');
DELETE [legend].[DataSetColumns] WHERE DataSet = 'Person';
----------------------------------------------------------------------------------
-- Person Table
----------------------------------------------------------------------------------
INSERT [legend].[DataSetColumns] (DataSet, ColumnIdx, ColumnName, DataType, Length, AllowNULL)
SELECT 'Person',  0, 'PersonSNum', 'int', 0, 'N' union
SELECT 'Person',  1, 'Title', 'varchar', 10, 'Y' union
SELECT 'Person',  2, 'FirstName', 'varchar', 30, 'N' union
SELECT 'Person',  3, 'LastName', 'varchar', 30, 'N' union
SELECT 'Person',  4, 'Suffix', 'varchar', 10, 'Y' union
SELECT 'Person',  5, 'Address', 'varchar', 50, 'Y' union
SELECT 'Person',  6, 'City', 'varchar', 30, 'Y' union
SELECT 'Person',  7, 'State', 'char', 2, 'Y' union
SELECT 'Person',  8, 'Zip', 'char', 5, 'Y' union
SELECT 'Person',  9, 'Zip4', 'char', 4, 'Y' union
SELECT 'Person', 10, 'Phone', 'Phone', 10, 'Y' union
SELECT 'Person', 11, 'Fax', 'Phone', 10, 'Y' union
SELECT 'Person', 12, 'Email', '[legend].[Email]', 0, 'Y'
SELECT 'Person', 13, 'IP', '[legend].[IP]', 0, 'Y'
-- SELECT 'Person', 14, 'SalesRange', '[legend].[SalesRange]', 30 union
-- SELECT 'Person', 15, 'EmployeeRange', '[legend].[EmployeeRange]', 30 -- union
;

SELECT * FROM [legend].[DataSetColumns] WHERE DataSet = 'Person';


INSERT [legend].[DataSet] VALUES ('PersonEmail','Person');
DELETE [legend].[DataSetColumns] WHERE DataSet = 'PersonEmail';
----------------------------------------------------------------------------------
-- PersonEmail Table
----------------------------------------------------------------------------------
INSERT [legend].[DataSetColumns] (DataSet, ColumnIdx, ColumnName, DataType, Length, AllowNULL, ForeignKey)
SELECT 'PersonEmail',  0, 'PersonSNum', 'int', 0, 'N', '[Person].[PersonSNum]' union
SELECT 'PersonEmail',  1, 'Email', '[legend].[Email]', 0, 'N', NULL -- union
-- SELECT 'PersonEmail',  2, 'Verified', '[legend].[YesNo]', 0, 'N'
;

SELECT * FROM [legend].[DataSetColumns] WHERE DataSet = 'PersonEmail';



-- need to add IP somewhere


INSERT [legend].[DataSet] VALUES ('PersonPhone','Person');

DELETE [legend].[DataSetColumns] WHERE DataSet = 'PersonPhone';
----------------------------------------------------------------------------------
-- PersonPhone Table
----------------------------------------------------------------------------------
INSERT [legend].[DataSetColumns] (DataSet, ColumnIdx, ColumnName, DataType, Length, AllowNULL)
SELECT 'PersonPhone',  0, 'PersonSNum', 'int', 0, 'N' union
SELECT 'PersonPhone',  1, 'Phone', '[legend].[Phone]', 0, 'N' union
SELECT 'PersonPhone',  2, 'CanText', '[legend].[YesNoUnknown]', 0, 'N'
;

select * from legend.DataSet

select * from [legend].[DataSetTypeRows]

-- BusinessPhone



-- INSERT [legend].[DataSet] VALUES ('List','List');


------------------------------------------------------------------
-- this might be the wrong way of doing the sort of things - like maybe its a List and its a ListPerson
------------------------------------------------------------------
INSERT [legend].[DataSet] VALUES ('PersonList','Person');

DELETE [legend].[DataSetColumns] WHERE DataSet = 'PersonList';
----------------------------------------------------------------------------------
-- PersonPhone Table
----------------------------------------------------------------------------------
INSERT [legend].[DataSetColumns] (DataSet, ColumnIdx, ColumnName, DataType, Length, AllowNULL, ForeignKey)
SELECT 'PersonList',  0, 'PersonSNum', 'int', 0, 'N',  '[legend].[PersonSNum]' union
SELECT 'PersonList',  1, 'ListSNum', 'int', 0, 'N', '[legend].[ListSNum]'
;


select * from [legend].[DataSet]

select * from [legend].[DataSetColumns]
