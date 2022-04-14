create database cinema;
use cinema;


create table hall(
Id int identity (1,1) primary key ,
Name nvarchar(50) not null,
SeatCount int check (SeatCount<250)
)

insert into hall(Name,SeatCount)
values('Otaq1',100),('Otaq2',50),('Otaq3',90),('Otaq4',30)



create table actors(
Id int identity (1,1) primary key ,
Name nvarchar(150) not null,
Surname nvarchar(150) default 'xxx',
Age int check (age<166and age>0)
)

insert into actors(Name,Surname,Age)
values('James','Bond',40),('Lewis ','Delaney ',15),('Warren ','Oates ',30)


create table session(
Id int identity (1,1) primary key ,
[Time] time not null
)
insert into session(Time)
values('20:00:00'),('15:45:00'),('10:00:00')


create table genres(
Id int identity (1,1) primary key ,
Name nvarchar(50) not null
)

insert into genres([Name])
values('Horror'),('Action'),('Adventure')



create table films(
Id int identity (1,1) primary key ,
Name nvarchar(50) not null,
Releasedate date not null
)
insert into films([Name],Releasedate)
values('Evdetek','2009-09-09'),('MrRobot','2015-12-19'),('Who am I','2018-08-09')


create table FilmGenres(
id int identity (1,1) primary key ,
FilmId int references films(Id) not null,
GenresId int references genres(Id) not null
)

insert into FilmGenres(FilmId,GenresId)
values(1,1),(2,2),(3,3)



create table Filmactors(
id int identity (1,1) primary key ,
FilmId int references films(Id) not null,
ActorID int references genres(Id) not null
)

insert into Filmactors(FilmId,ActorID)
values(1,1),(2,2),(3,3)

create table tickets(
Id int identity (1,1) primary key ,
SoldDate date DEFAULT getdate(),
Price decimal,
Place int check (100>Place),
CustomersId int references Customers(Id) not null,
HallId int references hall(Id) not null,
FilmId int references films(Id) not null,
SessonId int references session(Id) not null
)

insert into tickets(SoldDate,Price,Place,CustomersId,HallId,FilmId,SessonId)
values('2022-04-13',7,2,1,2,3,1),
('2022-04-13',15,1,2,3,1,2),
('2022-04-15',15,2,1,3,1,1),
('2022-04-13',19,2,3,1,1,3)


create table Customers(
Id int identity (1,1) primary key ,
[Name] nvarchar(150) not null,
Surname nvarchar(150) not null,
Age int check (age<166 and age>0) not null
)

insert into Customers([Name],Surname,Age)
values('Vusal','Aliyev',19),('test','Aliyev',39),('Unamed','Hax',29)

select *from hall
select *from actors

ALTER Function GetEmptySeat (@HallId int, @SessionId int)
Returns int
As
Begin
Declare @Count int
Select @Count = h.SeatCount - Count(s.Id) From tickets as t
Join Hall As h
On
h.Id = t.HallId
Join session as s
On
s.Id = t.SessonId
Where @HallId = h.Id and @SessionId = t.SessonId
Group by h.SeatCount, s.Id

IF @COUNT IS NULL
BEGIN
	SELECT @Count =Hall.SeatCount FROM tickets
	JOIN Hall
	ON Hall.Id=@HallId
	JOIN session
	ON session.Id =@sessionId

END
	Return @Count

End

select dbo.GetEmptySeat(1,1)





