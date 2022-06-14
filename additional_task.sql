--view for additional task 
--create view to present accounts with the highest number of games
go
CREATE VIEW highest_number_of_games AS
SELECT * FROM Accounts
ORDER BY Games DESC
	OFFSET 0 ROWS  
	FETCH NEXT 5 ROWS ONLY; 


--function that returns table and takes one parameter game_name. 
--The function returns all platforms dedicated for that game
go
create function getPlatforms(@game_name varchar(20)) returns table as
return 
	(select * from Platform where id_platform in (select Platform_id_platform from Game_platform where
	(Game_id_game = (select id_game from Game where game_name = @game_name))))
go
--select * from getPlatforms('Game3')

--function that returns table and takes first and last name as input parameters. 
--The function returns all games and their scores for a given account dedicated for that game
go
alter function getScores(@first_name varchar(100), @last_name varchar(100)) returns table as
return 
	select * from 
	(select id_game, game_name from Game where id_game = 
		(select Game_id_game from Game_platform where id =
			(select Game_platform_id from Game_platform_acc where(Accounts_account_id = 
				(select account_id from Accounts where firstName= @first_name and lastName=@last_name))))) as g
	 JOIN
	(select Score, Game_id_game from Game_platform_acc where
		(Accounts_account_id = (select account_id from Accounts where firstName= @first_name and lastName=@last_name))) as s
	 on g.id_game = s.Game_id_game
	 go

select * from getScores('Egers','Braho')

--trigger for additional task 
--create trigger which prevents deletion account if they have at least three games
go
CREATE TRIGGER check_number_of_ganes ON Accounts
AFTER DELETE
AS
BEGIN
	IF (SELECT Games from deleted)>=3
	BEGIN
		SELECT 'Account can`t be deleted! There are more than 3 games'
		ROLLBACK
	END
	ELSE if (SELECT Games from deleted)<3
	BEGIN
		SELECT 'The next values were deleted'
		SELECT * from deleted	
	END
END;

--to chechk trigger run this:

--delete from Accounts where firstName = 'Peter'
--select * from Accounts


