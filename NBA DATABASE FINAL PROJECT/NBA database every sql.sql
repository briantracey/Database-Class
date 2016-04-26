--Brian Tracey
--April 26 2016
--Final Project
--Database Management

--This is a script for the National Basketball Association and its players and teams.


--Drop these tables if they exist!
Drop table if exists Arena;
Drop table if exists Coach;
Drop table if exists COach_Of;
Drop table if exists DIvision;
Drop table if exists Draft;
Drop table if exists Future_Game;
Drop table if exists Game;
Drop table if exists People;
Drop table if exists Player;
Drop table if exists Player_For;
Drop table if exists Player_Position;
Drop table if exists Player_Stats;
Drop table if exists Positions;
Drop table if exists Previous_Game;
Drop table if exists Season;
Drop table if exists Season_Champion;
Drop table if exists Team;
Drop table if exists Team_Stats;



--People Table

create table People (
	PID 		Integer		Not null,
	FirstName 	text		Not NUll,
	LastName	text		not null,
	BirthDate	date		not null,
	primary key (PID)
	);

--Coach Table

create table Coach (
	PID		Integer 	Not null references People (PID),
	FirstYear 	Date		not null,
	primary key (PID)
	);

	
--Team Table

create table Team (
	TeamID		integer 	not null,
	ArenaID 	Integer		not null references Arena (ArenaID),	
	DivisionID	Integer		not null references Division (DivisionID),	 
	TeamCity	Text		Not NUll,
	TeamName	Text		Not NUll,
	primary key (TeamID)
	);

create table Coach_Of (
	PID 		Integer		not null references People (PID),
	TeamID		integer 	not null references Team (TeamID),
	StartDate	date 		not null,
	EndDate		Date		not null default Current_date,
	Primary key (PID)
	);
	
--Player Table

create table Player (
	PID		Integer		not null references People (PID),
	DraftYear	smallint	not null references Draft (DraftYear),
	Selection	smallint	not null default 'Undrafted',
	HeightIN	smallint	not null check (HeightIN > 0),
	WeightLBS	Smallint	Not null check (WeightLBS > 0),
	Primary key (PID)
	);

--Draft Table

create table Draft (
	DraftYear	smallint	not null,
	TeamID		integer 	not null references Team (TeamID),
	PID		Integer		not null references People (PID),
	Selection	smallint	not null check (Selection = 1),
	Primary key (DraftYear)
	);

--Player For Table

create table Player_For (
	PID 		Integer		not null references People (PID),
	TeamID		integer 	not null references Team (TeamID),	
	SignedDate	date		not null,
	EndDate		Date		not null default Current_date,
	JerseyNumber 	Integer		not null check (JerseyNumber >= 0),
	Primary key (PID,TeamID)
	);

--Player Position Table

create table Player_Position (
	PID 		Integer		not null references People (PID),
	PositionID	integer 	not null references Positions (PositionID),
	Primary key (PID, PositionID)
	);

--Positions Table

create table Positions (
	PositionID	integer 	not null,
	PositionName	Text		not null,	
	primary key (positionID)
	);



--Division Table
create type Conference as enum ('East','West');


create table Division (
	DivisionID	integer 	not null,
	DivisionName	Text		Not NUll,
	Conference	Text		Not null,
	TimeZone	Text		Not NUll Default 'Eastern',
	Primary key (DivisionID)
	);

 --Season Champion Table

create table Season_Champion (
	ChampionID	integer 	not null,
	SeasonID	integer 	not null references Season (SeasonID),
	TeamID		integer 	not null references Team (TeamID),
	primary key (ChampionID)
	);

 --Season Table

create table Season(
	SeasonID	integer 	not null,
	ChampionID	integer 	not null references Season_Champion (ChampionID),
	StartDate	Date		Not Null,
	EndDate		Date		Not Null default 'Current',
	primary key (SeasonID)
	);

 --Game Table

create Table Game (
	GameID		integer 	not null,
	SeasonID	integer 	not null references Season (SeasonID),	
	ArenaID		Integer		not null references Arena (ArenaID),
	HomeTeamID	integer		not null references Team (TeamID),
	AwayTeamID	integer		not null references Team (TeamID),
	DatePlayed	Date		Not null,
	primary key (GameID)
	);

--Arena Table

create table Arena (
	ArenaID		Integer		not null,	
	TeamID		integer 	not null references Team (TeamID),
	City		text		not null,
	ArenaName	text		not null,
	primary key (ArenaID)
	);
	
--Future Game Table

create table Future_Game ( 
	GameID		integer 	not null references Game (GameID),
	primary key (GameID)
	);

--Previous Game Table

create table Previous_Game (
	GameID		integer 	not null references Game (GameID),
	primary key (GameID)
	);

--Team Stats Table
Create type Result as enum ('W','L');


create table Team_Stats (	
	TeamID			integer 	not null references Team (TeamID),
	GameID			integer 	not null references Game (GameID),
	Result 			Text		not null,
	Score 			Text		not null,
	FGPercent		Smallint  	not null check (FGPercent >= 0 and FGPercent <= 100),
	ThreePointPercent	Smallint 	not null check (ThreePointPercent >= 0 and ThreePointPercent <= 100),
	FreeThrowPercent	Smallint 	not null check (FreeThrowPercent >= 0 and FreeThrowPercent <= 100),	
	Turnover		Integer		not null check (Turnover >=0),
	Assists			Integer		not null check (Assists >=0),
	Rebounds		Integer		not null check (Rebounds >=0),
	primary key (TeamID, GameID)
	);

--Player Stats Table

create table Player_Stats (	
	PID			integer 	not null references People (PID),
	GameID			integer 	not null references Game (GameID),
	Minutes			integer		not null check (Minutes >= 0),
	FGA			Integer		not null check (FGA >=0),
	FGM			Integer		not null check (FGM >=0),
	FGPercent		Smallint 	not null check (FGPercent >= 0 and FGPercent <= 100),
	ThreePointPercent	Smallint 	not null check (ThreePointPercent >= 0 and ThreePointPercent <= 100),
	FreeThrowPercent	Smallint 	not null check (FreeThrowPercent >= 0 and FreeThrowPercent <= 100),	
	TurnOver		integer		not null check (TurnOver >=0),
	Assists			Integer		not null check (Assists >=0),
	Rebounds		Integer		not null check (Rebounds >=0),
	Points			integer 	not null check (Points >=0),
	primary key (PID, GameID)
	);
	
	--arena insert 
	
	insert into Arena ( ArenaID, City, ArenaName)
values (1, 'Toronto', 'Air Canada Centre');

insert into Arena ( ArenaID, City, ArenaName)
values (2, 'Miami', 'American Airlines Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (3, 'Dallas', 'American Airlines Center');

insert into Arena ( ArenaID, City, ArenaName)
values (4, 'Orlando', 'Amway Center');

insert into Arena ( ArenaID, City, ArenaName)
values (5, 'San Antonio', 'AT&T Center');

insert into Arena ( ArenaID, City, ArenaName)
values (6, 'Indianopolis', 'Bankers Life Fieldhouse');

insert into Arena ( ArenaID, City, ArenaName)
values (7, 'New York', 'Barclays Center');

insert into Arena ( ArenaID, City, ArenaName)
values (8, 'Milwaukee', 'BMO Harris Bradley Center');

insert into Arena ( ArenaID, City, ArenaName)
values (9, 'Oklahoma City', 'Chesapeake Energy Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (10, 'Memphis', 'FedExForum');

insert into Arena ( ArenaID, City, ArenaName)
values (11, 'New York City', 'Madison Square Garden');

insert into Arena ( ArenaID, City, ArenaName)
values (12, 'Portland', 'Moda Center');

insert into Arena ( ArenaID, City, ArenaName)
values (13, 'Oakland', 'Oracle Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (14, 'Denver', 'Pepsi Center');

insert into Arena ( ArenaID, City, ArenaName)
values (15, 'Atlanta', 'Philips Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (16, 'Cleveland', 'Quicken Loans Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (17, 'Sacramento', 'Sleep Train Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (18, 'New Orleans', 'Smoothie King Center');

insert into Arena ( ArenaID, City, ArenaName)
values (19, 'Los Angeles', 'Staples Center');

insert into Arena ( ArenaID, City, ArenaName)
values (20, 'Phoenix', 'Talking Stick Resort Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (21, 'Minneapolis', 'Target Center');

insert into Arena ( ArenaID, City, ArenaName)
values (22, 'Boston', 'TD Garden');

insert into Arena ( ArenaID, City, ArenaName)
values (23, 'Auburn Hills', 'The Pallace at Auburn Hills');

insert into Arena ( ArenaID, City, ArenaName)
values (24, 'Charlotte', 'Time Warner Cable Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (25, 'Houston', 'Toyota Center');

insert into Arena ( ArenaID, City, ArenaName)
values (26, 'Chicago', 'United Center');

insert into Arena ( ArenaID, City, ArenaName)
values (27, 'Washington D.C.', 'Verizon Center');

insert into Arena ( ArenaID, City, ArenaName)
values (28, 'Salt Lake City', 'Vivint Smart Home Arena');

insert into Arena ( ArenaID, City, ArenaName)
values (29, 'Philadelphia', 'Wells Fargo Arena');


--insert champion

Insert Into Season_Champion (ChampionID, SeasonID, TeamID)
Values (1,1,19);

Insert Into Season_Champion (ChampionID, SeasonID, TeamID)
Values (2,2,3);

Insert Into Season_Champion (ChampionID, SeasonID, TeamID)
Values (3,3,2);

Insert Into Season_Champion (ChampionID, SeasonID, TeamID)
Values (4,4,2);

Insert Into Season_Champion (ChampionID, SeasonID, TeamID)
Values (5,5,5);

Insert Into Season_Champion (ChampionID, SeasonID, TeamID)
Values (6,6,13);

--insert coach of 

insert into Coach_Of (PID, TeamID, StartDate, EndDate)
Values (6, 23, '7/4/2014','6/20/2016');

insert into Coach_Of (PID, TeamID, StartDate, EndDate)
Values (12, 7, '2/8/2016','4/15/2016');

insert into Coach_Of (PID, TeamID, StartDate, EndDate)
Values (18, 11, '1/26/2016','6/20/2016');

insert into Coach_Of (PID, TeamID, StartDate, EndDate)
Values (24, 29, '6/14/2013','6/20/2016');

insert into Coach_Of (PID, TeamID, StartDate, EndDate)
Values (30, 1, '6/20/2011','6/20/2016');

insert into Coach_Of (PID, TeamID, StartDate, EndDate)
Values (36, 13, '6/14/2014','6/20/2016');


--insert division 

insert into Division (DivisionID, DivisionName, Conference, TimeZone)
Values (1, 'Atlantic', 'Eastern', 'Eastern');

insert into Division (DivisionID, DivisionName, Conference, TimeZone)
Values (2, 'Southeast', 'Eastern', 'Eastern');

insert into Division (DivisionID, DivisionName, Conference, TimeZone)
Values (3, 'Central', 'Eastern', 'Central');


insert into Division (DivisionID, DivisionName, Conference, TimeZone)
Values (4, 'Pacific', 'Western', 'Pacific');

insert into Division (DivisionID, DivisionName, Conference, TimeZone)
Values (5, 'Southwest', 'Western', 'Central');

insert into Division (DivisionID, DivisionName, Conference, TimeZone)
Values (6, 'Northwest', 'Western', 'Mountain West');

-- insert draft

insert into Draft (DraftYear, TeamID, PID, Selection)
Values (2000, 7, 33, 1);

insert into Draft (DraftYear, TeamID, PID, Selection)
Values (2001, 27, 1, 1);

insert into Draft (DraftYear, TeamID, PID, Selection)
Values (2002, 25, 15, 1);

insert into Draft (DraftYear, TeamID, PID, Selection)
Values (2003, 16, 37, 1);

insert into Draft (DraftYear, TeamID, PID, Selection)
Values (2004, 4, 16, 1);

insert into Draft (DraftYear, TeamID, PID, Selection)
Values (2005, 9, 19, 1);

--insert game 

	insert into Game (GameID, SeasonID, ArenaID, HomeTeamID, AwayTeamID,DatePlayed)
	Values (1, 7, 1,1,22, '3/15/2016');

	
	insert into Game (GameID, SeasonID, ArenaID, HomeTeamID, AwayTeamID,DatePlayed)
	Values (2, 7, 13,13, 20, '2/19/2016');

	
	insert into Game (GameID, SeasonID, ArenaID, HomeTeamID, AwayTeamID,DatePlayed)
	Values (3, 7, 7,7,11, '1/12/2016');

	
	insert into Game (GameID, SeasonID, ArenaID, HomeTeamID, AwayTeamID,DatePlayed)
	Values (4, 7, 2,2,16, '12/25/2015');

	insert into Game (GameID, SeasonID, ArenaID, HomeTeamID, AwayTeamID,DatePlayed)
	Values (5, 7, 5,5,9, '3/1/2016');


-- insert past and future games 


	insert into Future_Game (GameID)
	Values (4); 

	insert into Future_Game (GameID)
	Values (5); 



	insert into Previous_Game (GameID)
	Values (1); 

	insert into Previous_Game (GameID)
	Values (2); 

	insert into Previous_Game (GameID)
	Values (3); 
	
	--insert into people.sql wasnt backed up...awesome! 
	
	--insert player positions table
	
	Insert Into Player_Position (PID, PositionID)
Values (1,1); 

Insert Into Player_Position (PID, PositionID)
Values (2,2); 

Insert Into Player_Position (PID, PositionID)
Values (3,3); 
Insert Into Player_Position (PID, PositionID)
Values (4,3); 

Insert Into Player_Position (PID, PositionID)
Values (5,4); 

Insert Into Player_Position (PID, PositionID)
Values (8,5); 

Insert Into Player_Position (PID, PositionID)
Values (13,3);

Insert Into Player_Position (PID, PositionID)
Values (14,4);  


--player stats insert

insert into Player_Stats (PID, GameID, Minutes, FGA, FGM, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover, Assists, Rebounds, Points)
Values (1,1,36,19,11,58, 34, 75,4, 6,4,29);

insert into Player_Stats (PID, GameID, Minutes, FGA, FGM, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover, Assists, Rebounds, Points)
Values (27,1,35,15,5,33, 30, 40,3, 5,5,13);

insert into Player_Stats (PID, GameID, Minutes, FGA, FGM, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover, Assists, Rebounds, Points)
Values (33,2,38,22,13,59, 50, 75,4, 7,4,42);

insert into Player_Stats (PID, GameID, Minutes, FGA, FGM, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover, Assists, Rebounds, Points)
Values (35,2,38,13,8,62, 0, 75,4, 10,9,23);

insert into Player_Stats (PID, GameID, Minutes, FGA, FGM, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover, Assists, Rebounds, Points)
Values (37,2,40,20,10,50, 33, 100,7, 16,5,22);

insert into Player_Stats (PID, GameID, Minutes, FGA, FGM, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover, Assists, Rebounds, Points)
Values (40,2,33,18,7,39, 50, 90,6, 6,9,23);


--insert into player

insert into Player (PID, DraftYear, Selection, HeightIN, WeightLBS)
Values (1, 2002, '7', 70, 170);

insert into Player (PID, DraftYear, Selection, HeightIN, WeightLBS)
Values (33, 2004, '7', 75, 185);

insert into Player (PID, DraftYear, Selection, HeightIN, WeightLBS)
Values (14, 2003, '4', 85, 230);

insert into Player (PID, DraftYear, Selection, HeightIN, WeightLBS)
Values (37, 2001, '3', 72, 205);

insert into Player (PID, DraftYear, Selection, HeightIN, WeightLBS)
Values (28, 2002, '5', 83, 265);

insert into Player (PID, DraftYear, Selection, HeightIN, WeightLBS)
Values (22, 2004, '8', 82, 245);

insert into Player (PID, DraftYear, Selection, HeightIN, WeightLBS)
Values (34, 2003, '3', 78, 225);

insert into Player (PID, DraftYear, Selection, HeightIN, WeightLBS)
Values (11, 2001, '17', 81, 235);

--insert player for

insert into Player_For (PID, TeamID, SignedDate,EndDate,JerseyNumber)
Values (1,22, '1/6/2014', '6/20/2016', 4);

insert into Player_For (PID, TeamID, SignedDate,EndDate,JerseyNumber)
Values (2,22, '7/20/2012', '6/20/2016', 0);

insert into Player_For (PID, TeamID, SignedDate,EndDate,JerseyNumber)
Values (33,13, '7/20/2009', '6/20/2016', 30);

insert into Player_For (PID, TeamID, SignedDate,EndDate,JerseyNumber)
Values (40,20, '7/20/2009', '6/20/2016', 32);

insert into Player_For (PID, TeamID, SignedDate,EndDate,JerseyNumber)
Values (22,30, '7/20/2015', '6/20/2016', 8);

insert into Player_For (PID, TeamID, SignedDate,EndDate,JerseyNumber)
Values (29,1, '7/20/2012', '6/20/2016', 30);

--positions table

insert into Positions (PositionID, PositionName)
Values (1, 'Point Guard'); 

insert into Positions (PositionID, PositionName)
Values (2, 'Shooting Guard'); 

insert into Positions (PositionID, PositionName)
Values (3, 'Small Forward'); 

insert into Positions (PositionID, PositionName)
Values (4, 'Power Forward'); 

insert into Positions (PositionID, PositionName)
Values (5, 'Center'); 

--insert into seasons 

insert into Season (SeasonID, StartDate, EndDate)
Values (1,'9/1/2009','6/20/2010'); 

insert into Season (SeasonID, StartDate, EndDate)
Values (2,'9/1/2010','6/20/2011'); 

insert into Season (SeasonID, StartDate, EndDate)
Values (3,'9/1/2011','6/20/2012'); 

insert into Season (SeasonID, StartDate, EndDate)
Values (4,'9/1/2012','6/20/2013'); 

insert into Season (SeasonID, StartDate, EndDate)
Values (5,'9/1/2013','6/20/2014'); 

insert into Season (SeasonID, StartDate, EndDate)
Values (6,'9/1/2014','6/20/2015'); 

insert into Season (SeasonID, StartDate, EndDate)
Values (7,'9/1/2015','6/20/2016'); 

--insert team stat

insert into Team_Stats (TeamID, GameID, Result, Score, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover,Assists, Rebounds)
Values (1,1,'L', '109-106', 42, 34, 77, 22, 21, 29); 

insert into Team_Stats (TeamID, GameID, Result, Score, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover,Assists, Rebounds)
Values (22,1,'W', '109-106', 44, 39, 82, 14, 24, 33); 

insert into Team_Stats (TeamID, GameID, Result, Score, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover,Assists, Rebounds)
Values (13,2,'W', '122-116', 51, 41, 83, 16, 29, 27); 

insert into Team_Stats (TeamID, GameID, Result, Score, FGPercent, ThreePointPercent, FreeThrowPercent, Turnover,Assists, Rebounds)
Values (20,2,'L', '122-116', 49, 37, 76, 20, 28, 33); 

--insert team

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (1, 1, 1, 'Toronto', 'Raptors');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (2,2,2, 'Miami', 'Heat');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (3,3,5, 'Dallas', 'Mavericks');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (4,4,2, 'Orlando', 'Magic');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (5,5,5, 'San Antonio', 'Spurs');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (6,6,3, 'Indiana', 'Pacers');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (7,7,1, 'Brooklyn', 'Nets');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (8,8,3, 'Milwaukee', 'Bucks');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (9,9,6, 'Oklahoma City', 'Thunder');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (10,10,5, 'Memphis', 'Grizzlies');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (11,11,1, 'New York', 'Knicks');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (12,12,6, 'Portland', 'Trailblazers');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (13,13,4,'Golden State', 'Warriors');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (14,14,6, 'Denver', 'Nuggets');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (15,15,2,'Atlanta', 'Hawks');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (16,16,3, 'Cleveland', 'Cavaliers');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (17,17,4, 'Sacramento', 'Kings');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (18,18,5, 'New Orleans', 'Pelicans');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (19, 19, 4, 'Los Angeles', 'Lakers');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (20, 19, 4, 'Los Angeles', 'Clippers');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (21,21, 6, 'Minnesota', 'Timberwolves');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (22,22,1, 'Boston', 'Celtics');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (23,23,3, 'Detroit', 'Pistons');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (24, 24, 2, 'Charlotte', 'Hornets');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (25, 25, 4, 'Houston', 'Rockets');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (26, 26, 3, 'Chicago', 'Bulls');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (27, 27, 2, 'Washington', 'Wizards');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (28,28,6, 'Utah', 'Jazz');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (29, 29, 1, 'Philadelphia', '76ers');

insert into Team (TeamID, ArenaID, DivisionID, TeamCity, TeamName)
Values (30, 20, 4, 'Phoenix', 'Suns');

-- report 2 coach and join team

select people.FirstName, people.LastName, people.BirthDate, team.teamname
from people 
inner join coach_of
on people.PID=coach_of.pid
inner join team on coach_of.teamID = team.TeamID;


--report 1

select extract(year from Season.StartDate) as "Start Year", extract(year from Season.EndDate) as "End Year"
From Season
where now() > Season.EndDate; 

--security 

create role databaseAdmin;
Grant all privileges
on all tables in schema public
to databaseAdmin;

create role generalAdmin;
grant insert, update, select
on all tables in schema public
to generalAdmin;

create role publicUser;
grant select
on all tables in schema public 
to publicUser; 

--stored procedure celtic roster

create or replace function TeamRoster (Roster text)
returns table("Team Name" text, "First Name" text, "Last Name" text)
as 
$$
Begin
Return Query
Select team.teamName as  "Team Name", people.FirstName as "First Name", people.LastName as "Last Name"
from people 
inner join player_for on people.pid = player_for.pid
inner join team on player_for.teamID = team.teamID
where Roster = team.teamname
group by people.firstname, people.lastname, team.teamname
order by people.lastname asc; 
end;
$$
language plpgsql; 

select TeamRoster ('Celtics');

--stored procedure find position example PG

create or REplace function PlayersPosition (positions1 text)
returns table ("First Name" text, "Last Name" text, "Position" text)
as
$$
Begin
Return Query
select people.FirstName as "First Name", people.LastName as "LastName", positions.PositionName as "Position"
from people 
inner join player
on people.PID = player.PID
inner join player_position 
on player.PID = player_position.PID
inner join positions 
on player_position.PositionID = positions.PositionID
where positions.positionName = positions1 
group by people.FirstName, people.LastName, positions.positionName
order by people.LastName;
end;
$$
language plpgsql;

select PlayersPosition ('Point Guard');

--trigger

CREATE TRIGGER Jersey_Number
    BEFORE UPDATE ON Player_for
    FOR EACH ROW
    WHEN (OLD.JerseyNumberIS DISTINCT FROM NEW.JerseyNumber)
    EXECUTE PROCEDURE check_Jersey_Number();
    
    
    --view arena
    
    create or replace view TeamArenas as 
select Team.TeamName as Team_Name,
Team.TeamCity as Team_City,
Arena.ArenaName as Arena_Name
from Team, Arena

where team.arenaID=Arena.arenaID
group by team.teamname, team.teamcity, arena.arenaname
order by team.teamcity;

Select * from TeamArenas

--view players and points 

create or replace view PlayerPoint as 
select 
people.FirstName as First_Name,
people.LastName as Last_Name,
Team.TeamName as Team_Name,
Team.TeamCity as Team_City,
player_stats.Points as player_points

from Team
inner join player_for on team.teamID = player_for.teamID
inner join player on player_for.pid = player.pid
inner join player_stats on player.pid = player_stats.pid
inner join people on Player_stats.pid = people.pid
group by people.FirstName, People.LastName, team.teamname, team.teamcity, player_stats.Points
order by people.LastName;

Select * from PlayerPoint



