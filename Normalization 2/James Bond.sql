--Brian Tracey
--Normalization Lab 2
--James Bond New Actor 
--April 5th 2016


drop table if exists Actors;
create table if not exists Actors
(
aid                                     serial   not null primary key,
actor                                   text     not null,
address                                 text     not null,
BirthDate                               date     not null,
HairColor                              text     not null,
EyeColor                               text     not null,
HeightInches                           text     not null,
WeightLbs                              text     not null,
Spouse                                 text     not null,
FavColor                               text     not null,
ScreenActors_guild_anniversary_date    date     not null
);


drop table if exists Movies;
create table if not exists Movies
(
mid                          serial  not null primary key,
movie_name                   text    not null,
year_released                text    not null,
MPAA_number                  text     not null,
domestic_box_office_salesUSD money   not null,
foreign_box_office_salesUSD  money   not null,
dvd_bluray_salesUSD          money   not null
);


drop table if exists Directors;
create table if not exists Directors
(
did                               serial  not null primary key,
director                          text    not null,
spouse                            text    not null,
address                           text    not null,
film_school_attended              text    not null,
directors_guild_anniversary_date  date    not null,
fav_lens_maker                    text    not null
);


drop table if exists Actors_Movies;
create table if not exists Actors_Movies
(
amid             serial not null primary key,
aid              int   not null references actors(aid),
did              int   not null references directors(did),
mid              int   not null references movies(mid),
movie_name       text   not null,
year_released    text   not null,
actor            text   not null,
director         text   not null
);

drop table if exists Directors_Movies;
create table if not exists Directors_Movies
(
dmid             serial not null primary key,
mid              int   not null references movies(mid),
did              int   not null references directors(did),
movie_name       text   not null,
year_released    text   not null,
director         text   not null
);



--Actors Table
insert into actors(actor, address, BirthDate, HairColor, EyeColor, HeightInches, WeightLbs, Spouse, FavColor, ScreenActors_guild_anniversary_date)
	values ('Jonah Hill' , '5 Wall Street' , 'July 19 1994', 'Red', 'Blue', '5-7', '230', 'Bachelor', 'Green', '04-12-2000');
insert into actors(actor, address, BirthDate, HairColor, EyeColor, HeightInches, WeightLbs, Spouse, FavColor, ScreenActors_guild_anniversary_date)
	values ('Christian Bale' , '3 Batman Blvd', 'January 30, 1978', 'Brown', 'Brown', '6-0', '190', 'Amanda', 'Blue', '03-26-2004');
insert into actors(actor, address, BirthDate, HairColor, EyeColor, HeightInches, WeightLbs, Spouse, FavColor, ScreenActors_guild_anniversary_date)
	values ('Leonardo DiCaprio' , '5 Beverly Hills Rd', 'June 5, 1974', 'Hazel', 'Brown', '6-1', '202', 'Bachelor', 'Green', '06-21-2001');
insert into actors(actor, address, BirthDate, HairColor, EyeColor, HeightInches, WeightLbs, Spouse, FavColor, ScreenActors_guild_anniversary_date)
	values ('Sean Connery' , '5 Overrated Lane', 'August 25, 1930', 'Brown', 'Brown', '5-10', '200', 'Jessica', 'Red', '10-25-2008');
insert into actors(actor, address, BirthDate, HairColor, EyeColor, HeightInches, WeightLbs, Spouse, FavColor, ScreenActors_guild_anniversary_date)
	values ('Idra Elbis ' , '9 Mulholland Drive', 'May 5, 1981', 'Brown', 'Brown', '6-2', '200', 'Stella', 'Purple', '1-13-2010');

--Movies Table

insert into movies(movie_name, year_released, MPAA_number, domestic_box_office_salesUSD, foreign_box_office_salesUSD, dvd_bluray_salesUSD)
	values ('The Dark Knight', '2008', '345', 533345358, 469546000, 262543772);
insert into movies(movie_name, year_released, MPAA_number, domestic_box_office_salesUSD, foreign_box_office_salesUSD, dvd_bluray_salesUSD)
	values ('Django Unchained', '2012', '135',  850495319, 35486003, 37358635);
insert into movies(movie_name, year_released, MPAA_number, domestic_box_office_salesUSD, foreign_box_office_salesUSD, dvd_bluray_salesUSD)
	values ('Superbad', '2006', '678', 4589630663, 445960359604, 3546922);
insert into movies(movie_name, year_released, MPAA_number, domestic_box_office_salesUSD, foreign_box_office_salesUSD, dvd_bluray_salesUSD)
	values ('Indiana Jones', '1989', '455', 116601172, 114600000, 19644793);
insert into movies(movie_name, year_released, MPAA_number, domestic_box_office_salesUSD, foreign_box_office_salesUSD, dvd_bluray_salesUSD)
	values ('Goldfinger', '1964', '990', 93819282, 839849289, 123712388);
	
--Directors Table
insert into directors(director, spouse, address, film_school_attended, directors_guild_anniversary_date,fav_lens_maker)
	values ('Seth Rogan', 'Jenna', '5 Long Drive', 'Marist College', '11-11-1980', 'Canon' );
insert into directors(director, spouse, address, film_school_attended, directors_guild_anniversary_date,fav_lens_maker)
	values ('Quintin Terrintino', 'Michele', '9 Australia Lane' , 'Univeristy of Brisbane', '07-10-1998', 'Bolex');
insert into directors(director, spouse, address, film_school_attended, directors_guild_anniversary_date,fav_lens_maker)
	values ('Guy Hamilton', 'Brianna', '69 Guy Ct', 'University of Miami', '09-09-1999', 'Hoya');
insert into directors(director, spouse, address, film_school_attended, directors_guild_anniversary_date,fav_lens_maker)
	values ('Christopher Nolan', 'Emily', '7 Best Director Drive', 'Harvard', '02-01-1984', 'Hasselblad');
insert into directors(director, spouse, address, film_school_attended, directors_guild_anniversary_date,fav_lens_maker)
	values ('Steve Speilberg', 'Bachelor', '8 IT Lane', 'Princeton', '03-15-1982', 'Cokin');


--Actors Movies Table
insert into actors_movies(aid, did, mid, movie_name, year_released, actor, director)
	values('2','4','1','The Dark Knight', '2008', 'Christian Bale', 'Christopher Nolan');
insert into actors_movies(aid, did, mid, movie_name, year_released, actor, director)
	values('4','3','5','Goldfinger', '1964', 'Sean Connery', 'Guy Hamilton');
insert into actors_movies(aid, did, mid, movie_name, year_released, actor, director)
	values('3','2','2','Django Unchained', '2012', 'Leonardo DiCaprio', 'Quintin Terrintino');
insert into actors_movies(aid, did, mid, movie_name, year_released, actor, director)
	values('1','1','3','Superbad', '2012', 'Jonah Hill', 'Seth Rogan');
insert into actors_movies(aid, did, mid, movie_name, year_released, actor, director)
	values('4','5','4','Indiana Jones', '1989', 'Sean Connery', 'Steven Spielberg');


--Directors Movies Table
insert into directors_movies(mid, did, movie_name, year_released, director)
	values('1','4','The Dark Knight', '2008', 'Christopher Nolan');
insert into directors_movies(mid, did, movie_name, year_released, director)
	values('5','3','Goldfinger', '1964', 'Guy Hamilton');
insert into directors_movies(mid, did, movie_name, year_released, director)
	values('2','2','Django Unchained', '2012', 'Quintin Terrintino');
insert into directors_movies(mid, did, movie_name, year_released, director)
	values('3','1','Superbad', '2012', 'Seth Rogan');
insert into directors_movies(mid, did, movie_name, year_released, director)
	values('4','5','Indiana Jones', '1989','Steven Spielberg');


select director
from Actors_Movies am
where am.actor = 'Sean Connery'