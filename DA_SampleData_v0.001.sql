USE DA;
GO

-- select * from Coop.Coop

/*
--------------------------------------------------------------------
-- Sample Coops to get us started testing
--------------------------------------------------------------------
DELETE [coop].[Coop];
 GO

SET IDENTITY_INSERT DA.Coop.Coop ON;
INSERT [coop].[Coop] ( CoopId, CoopType, CoopName)
SELECT 0, 'Sys','System D' UNION
SELECT 1, 'Shop','Medco' UNION
SELECT 2, 'Shop','Green Avalanch' UNION
SELECT 3, 'Grow','Project Green' UNION
SELECT 4, 'Make','Gunjah Whalla Company' UNION
SELECT 5, 'Vend','Gunjah Whalla Sales' UNION
SELECT 6, 'Grow','Gunjah Whalla Grow';
SET IDENTITY_INSERT DA.Coop.Coop OFF;
 GO

-- select * from Coop.Coop

--------------------------------------------------------------------
-- Sample Accts to get us going
--------------------------------------------------------------------

DELETE DA.coop.Acct;
 GO

SET IDENTITY_INSERT DA.Coop.Acct ON;

INSERT [coop].[Acct] (AcctId, CoopId, SuperAcctId, AcctType, AcctName, ShareCnt)
SELECT 1, 1, NULL, 'Asset', 'Bitcoin Wallet A', 0 UNION
SELECT 2, 1, NULL, 'Asset', 'Bitcoin Wallet B', 0 UNION
SELECT 3, 1, NULL, 'Asset', 'Cash', 0 UNION
SELECT 4, 1, NULL, 'Asset', 'Equipment', 0 UNION
SELECT 5, 1, NULL, 'Asset', 'Stock/Inventory', 0 UNION
SELECT 6, 1, NULL, 'Equity', 'David', 25000 UNION
SELECT 7, 1, NULL, 'Equity', 'Harris', 25000 UNION
SELECT 8, 1, NULL, 'Equity', 'AJ', 25000 UNION
SELECT 9, 1, NULL, 'Equity', 'TJ', 25000 UNION
SELECT 10, 1, NULL, 'Liability', 'Chainz', 0 UNION
SELECT 11, 1, NULL, 'Liability', 'Crow', 0 UNION
SELECT 12, 1, NULL, 'Liability', 'Expense - Office Supplies', 0 UNION
SELECT 13, 1, NULL, 'Liability', 'Expense - Travel / Gas Money', 0 UNION
SELECT 14, 1, NULL, 'Liability', 'Expense - Utilities', 0 UNION
SELECT 15, 1, 14, 'Liability', 'Electric', 0 UNION
SELECT 16, 1, 14, 'Liability', 'Internet', 0 UNION
SELECT 17, 1, 14, 'Liability', 'Phone', 0;
 GO

SET IDENTITY_INSERT DA.Coop.Acct OFF;
 GO

-- select * from coop.Acct

-- select * from coop.Acct


--------------------------------------------------------------------
-- Create some controllers
--------------------------------------------------------------------
DELETE DA.coop.Control;
 GO

SET IDENTITY_INSERT DA.Coop.Control ON;

INSERT [coop].[Control] (ControlId, Name, Passwd)
SELECT 1,'Chainz',12345 UNION
SELECT 2,'TJ',444 UNION
SELECT 3,'AJ',222
 GO

SET IDENTITY_INSERT DA.Coop.Control OFF;
*/

-- select * from D.coop.Control

SET IDENTITY_INSERT DA.coop.Permission ON;

insert coop.Permission (PermissionId, Area, PermissionName)
SELECT 0, 'coop', 'Permission' UNION
SELECT 1, 'coop', 'Coop' UNION
SELECT 2, 'coop', 'Control' UNION
SELECT 3, 'coop', 'ControlCoop' UNION
SELECT 4, 'coop', 'Acct' UNION
SELECT 5, 'coop', 'AcctLedger' UNION
SELECT 6, 'coop', 'AcctLedgerTransaction' UNION
SELECT 7, 'coop', 'Currency' UNION
SELECT 8, 'coop', 'PeriodWeek' --  UNION





SET IDENTITY_INSERT DA.coop.Permission OFF;


--  select * from coop.Permission

-- scoop.Permission