--triggers
GO
CREATE TRIGGER checkAccounts ON Accounts
AFTER UPDATE, INSERT
AS
    IF (SELECT balance FROM inserted)<0
	BEGIN
		SELECT 'Negative balance! Error!';
		ROLLBACK
	END
	IF (SELECT Games FROM inserted)<0
	BEGIN
		SELECT 'Error! Negative number of games';
		ROLLBACK
	END



INSERT INTO Accounts (firstName, lastName, account_id, Games,
   balance, password, platform_name, Region_region_id)
VALUES ('Peter', 'Johnson', next value for seq_accounts,5, 100, '212345', 'platform', 1);

INSERT INTO Accounts (firstName, lastName, account_id,Games,
   balance, password, platform_name, Region_region_id)
VALUES ('John', 'Watson', next value for seq_accounts,-3, 100, '212345', 'platform', 1);

INSERT INTO Accounts (firstName, lastName, account_id,Games,
   balance, password, platform_name, Region_region_id)
VALUES ('John', 'Watson', next value for seq_accounts,3, -100, '212345', 'platform', 1);

INSERT INTO Accounts (firstName, lastName, account_id,Games,
   balance, password, platform_name, Region_region_id)
VALUES ('John', 'Watson', next value for seq_accounts,3, 100, '212345', 'platform', 1);

INSERT INTO Accounts (firstName, lastName, account_id, Games,
   balance, password, platform_name, Region_region_id)
VALUES ('John', 'Watson', next value for seq_accounts,-3, 100, '212345', 'platform', 1);


CREATE TRIGGER check_Game_platform ON Game_platform
AFTER UPDATE, INSERT
AS
BEGIN
    IF (SELECT release_year FROM inserted)<1962 or (SELECT release_year FROM inserted)>2022
	BEGIN
		SELECT 'WRONG YEAR!';
		ROLLBACK
	END
END;

CREATE TRIGGER delete_accounts ON Accounts
AFTER DELETE
AS
BEGIN
	SELECT 'The next values were deleted'
	SELECT * from deleted
END;



--views
alter VIEW view_Accounts_with_region AS
SELECT firstName, lastName, account_id, Games, balance, Region_region_id, region_name FROM Accounts, Region
WHERE Games>2
AND
region_id = Region_region_id;
go

alter VIEW view_Game_platform AS
SELECT * FROM Game_platform
WHERE Region_region_id=3;

go
alter VIEW view_regoin AS
SELECT region_id, region_name, firstName, lastName, Games  FROM Region, Accounts
Where Region_region_id = region_id
go