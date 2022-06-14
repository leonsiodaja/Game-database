--create sequence for each table to generate values
--into primary key column

create sequence seq_accounts--
start with 1
increment by 1;

create sequence seq_publisher--
start with 1
increment by 1;

create sequence seq_game--
start with 1
increment by 1;

create sequence seq_genre--
start with 1
increment by 1;

create sequence seq_region--
start with 1
increment by 1;

create sequence seq_platform--
start with 1
increment by 1;

create sequence seq_game_platform--
start with 1
increment by 1;

create sequence seq_game_platform_acc--
start with 1
increment by 1;
--implement a procedure to insert a new publisher

go

create procedure insertPublisher @publisher_name varchar(100) as
begin
begin try
 begin transaction 
   insert into Publisher values(next value for seq_publisher, @publisher_name)
 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;

--run the procedure a few times to insert a few countries
exec insertPublisher 'Srege Games'
exec insertPublisher 'Valve'--33
exec insertPublisher 'Ubisoft'--65
exec insertPublisher 'Nintendo'
exec insertPublisher 'Rockstar Games'


select * from Publisher

--implement a procedure to insert a new platform

go

create procedure insertPlatform @platform_name varchar(100) as
begin
begin try
 begin transaction 
   insert into Platform values(next value for seq_platform, @platform_name)
 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;

--run the procedure a few times to insert a few platform

exec insertPlatform 'Windows'
exec insertPlatform 'Android'
exec insertPlatform 'IOS'
exec insertPlatform 'PS5'
exec insertPlatform 'Nintendo Switch'


select * from Platform

--implement a procedure to insert a new game

go

create procedure insertGame @game_name varchar(100), @Genre_id_genre int, @Publisher_id_publisher int as
begin
begin try
 begin transaction 
   insert into Game values(next value for seq_game, @game_name, @Genre_id_genre, @Publisher_id_publisher)
 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;

--run the procedure a few times to insert a few platform

exec insertGame @game_name= 'Volfenstein3D', @Genre_id_genre=1,@Publisher_id_publisher=1
exec insertGame 'Haunted Asylumn', @Genre_id_genre=1,@Publisher_id_publisher=1
exec insertGame 'Minecraft'
exec insertGame 'GTA V'
exec insertGame @game_name='Assassins Creed',@Genre_id_genre=1,@Publisher_id_publisher=65


select * from Game

--implement a procedure to insert a new game

go

create procedure insertGamePlatform @release_year int, @Game_id_game int, @Platform_id_platform int, @Region_id_region int as
begin
begin try
 begin transaction 
   insert into Game_Platform values(next value for seq_game_platform, @release_year, @Game_id_game , @Platform_id_platform , @Region_id_region )
 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;

--run the procedure a few times to insert a few platform

exec insertGamePlatform 2022, 1,1,1
exec insertGamePlatform 2010, 1,2,1
exec insertGamePlatform 2019, 1,3,1
exec insertGamePlatform 2018, 1,4,1
exec insertGamePlatform 2017, 1,5,1


select * from Game_Platform

--implement a procedure to insert a new game

go

alter procedure insertGamePlatformAcc @score int,  @Game_platform_id int, @Account_account_id int, @Game_id_game int as
begin
begin try
 begin transaction 
   insert into Game_Platform_Acc values(next value for seq_game_platform_acc, @score,  @Game_platform_id, @Account_account_id, @Game_id_game)
 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;
--run the procedure a few times to insert a few platform

exec insertGamePlatformAcc 1,145,70,1
exec insertGamePlatformAcc 3,177,500,1
exec insertGamePlatformAcc 2,244,0,1


select * from Game_Platform_Acc

--implement a procedure to insert a new genre

go

create procedure insertGenre @genre_name varchar(300) as
begin
begin try
 begin transaction 
   insert into Genre values(next value for seq_genre, @genre_name)
 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;

--run the procedure a few times to insert a few countries

exec insertGenre 'Action'
exec insertGenre 'Adventure'
exec insertGenre 'Arcade'
exec insertGenre 'Board'
exec insertGenre 'Card'
exec insertGenre 'Casual'
exec insertGenre 'Puzzle'
exec insertGenre 'Racing'
exec insertGenre 'Role Playing'
exec insertGenre 'Simulation'
exec insertGenre 'Sports'
exec insertGenre 'Strategy'
exec insertGenre 'Trivia'
exec insertGenre 'Word'


select * from Genre

--implement a procedure to insert a new game

go

create procedure insertRegion @region_name varchar(100) as
begin
begin try
 begin transaction 
   insert into Region values(next value for seq_region, @region_name)
 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;

--run the procedure a few times to insert a few platform

exec insertRegion 'Europe'
exec insertRegion 'North America'
exec insertRegion 'Asia'
exec insertRegion 'Africa'
exec insertRegion 'South America'
exec insertRegion 'Oceania'

select * from Region


--implement a procedure to insert a new Accounts

alter procedure insertAccount @firstName varchar(100), @lastName varchar(100),  @Games int, @balance money, @password varchar(100), @platform_name varchar(100), @region_id  int as
begin
begin try
 begin transaction 
   insert into Accounts values (next value for seq_accounts,@firstName,@lastName,@Games,@balance,@password,@platform_name,@region_id)
 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;
 
--run the procedure to insert addresses
exec insertAccount  @firstName='Egers', @lastName='Braho',
            @balance=100000000, @password='password', @Games=100, @platform_name='Nintendo Switch', @region_id=1

select * from Accounts

exec insertAccount @firstName='Leonsio', @lastName='Daja',
            @balance=10, @password='password', @Games=1, @platform_name='Android', @region_id=1
--currently no country with id=5 so the procedure prints the error message

--potential solutions
--first one
--let's implement function to check if country_id exists in the Country table
go
create function checkAccount(@account_id int) returns int
as
begin
declare @result int;
  if exists (select 1 from Accounts where account_id=@account_id)
     set @result = 1;
  else
      set @result = 0;
      --select 'There is no account with id='+cast(@account_id as varchar(100));
      --select 'Please provide valid account_id'
   return @result
end;

select top 10 * from Genre

go

--second one 
alter procedure insertGame @game_name varchar(40), @id_game int,  @Publisher_id_publisher int, @genre_name varchar(50)  as
begin
declare @Genre_id_genre_var int

begin try
 begin transaction
      select @Genre_id_genre_var=id_genre from Genre where genre_name=@genre_name
	  if @Genre_id_genre_var is null
	  begin
		set @Genre_id_genre_var = next value for seq_genre
		insert into Genre values(@Genre_id_genre_var,@genre_name)
	  end
     insert into Game values(next value for seq_game, @game_name,@Genre_id_genre_var,@Publisher_id_publisher)

 commit transaction
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
	if @@TRANCOUNT>0 rollback
end catch
end;

--exec  declare @insertGame int @game_name='Counter Strike', @id_game=7, @Genre_id_genre=1,@Publisher_id_publisher=20

select * from Game