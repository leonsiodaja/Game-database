create clustered index idx_Accounts 
on Accounts(account_id)

create nonclustered index idx_Accounts 
on Accounts(firstName)

--indexes for Game
create clustered index idx_Game on Game(game_name)
drop table Game
create nonclustered index idx_Game on Game(game_name)

--indexes for Game_platform
create clustered index idx_Game_platform on Game_platform(release_year)
drop table Game_platform
create nonclustered index idx_Game_platform on Game_platform (release_year)

--indexes for Game_platform_acc
create clustered index idx_Game_platform_acc on Game_platform_acc(game_platform_id)
drop table Game_platform
create nonclustered index idx_Game_platform_acc on Game_platform_acc (game_platform_id)


--indexes for Genre

create clustered index idx_Genre on Genre (genre_name)
drop table Game_platform
create nonclustered index idx_Genre  on Genre  (genre_name)



--indexes for Platform

create clustered index idx_Platform on Platform (platform_name)
drop table Platform
create nonclustered index idx_Platform  on Platform  (platform_name)


--indexes for Publisher

create clustered index idx_Publisher on Publisher (publisher_name)
drop table Publisher
create nonclustered index idx_Publisher on Publisher (publisher_name)   


--indexes for Region

create clustered index idx_Region on Region (region_name)
drop table Region
create nonclustered index idx_Region on Region (region_name) 



--retrieve data from database 

SELECT * FROM Accounts
SELECT firstName, lastName from Accounts

SELECT G.id_genre, Gs.Genre_id_genre, Gs.game_name
FROM Genre AS G
INNER JOIN Game AS Gs
ON G.id_genre = Gs.Genre_id_genre
   