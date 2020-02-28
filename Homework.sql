
--1. Create a database with the name of your choice
Create Database Homework;


--2. Create a table called Director with following columns: FirstName, LastName, Nationality and Birth date. Insert 5 rows into it.
CREATE TABLE Director(
DirectorID int IDENTITY(1,1) NOT NULL,
FirstName nvarchar (MAX) NOT NULL,
LastName nvarchar (MAX) NOT NULL,
Nationality nvarchar (MAX) NOT NULL,
Birthdate date,
PRIMARY KEY(DirectorID));


INSERT INTO Director (FirstName, LastName, Nationality, Birthdate)
VALUES ('Peter', 'Farrelly', 'american', '1967-12-30'),
       ('Christopher', 'Nolan', 'american', '1977-02-20'),
	   ('Damien', 'Chazelle', 'english', '1962-08-10'),
	   ('Alfonso', 'Cuaron', 'spanish', '1980-09-15'),
	   ('Clint', 'Eastwood', 'american', '1930-05-31');


--3. Delete the director with id = 3
DELETE FROM Director
WHERE DirectorID = 3;


--4. Create a table called Movie with following columns: DirectorId, Title, ReleaseDate, Rating and Duration. Each movie has a director. Insert some rows into it
CREATE TABLE Movie (
MovieID int IDENTITY(1,1) NOT NULL,
DirectorID int  NOT NULL,
Title nvarchar(MAX) NOT NULL,
ReleaseDate date,
Rating int,
Duration time,
PRIMARY KEY(MovieID));

INSERT INTO Movie (DirectorID,Title, ReleaseDate, Rating, Duration)
VALUES ('1','Green Book', '2018-11-16', '8', '02:10:00'),
       ('2','Dunkirk', '2017-07-21', '7', '01:46:00'),
	   ('3','La La Land', '2016-12-25', '8', '02:08:00'),
	   ('3','Whiplash', '2015-02-06', '8', '01:46:00'),
	   ('4','Gravity', '2013-09-04', '7', '01:31:00');


--5. Update all movies that have a rating lower than 10.
UPDATE Movie
SET Rating = 10 WHERE Rating < 10;


--6. Create a table called Actor with following columns: FirstName, LastName, Nationality, Birth date and PopularityRating. Insert some rows into it.
CREATE TABLE Actor (
ActorID int IDENTITY(1,1) NOT NULL,
FirstName nvarchar(MAX) NOT NULL,
LastName nvarchar (MAX) NOT NULL,
Nationality nvarchar (MAX) NOT NULL,
BirthDate date,
PopularityRating int,
PRIMARY KEY(ActorID));

INSERT INTO Actor(FirstName, LastName, Nationality, BirthDate, PopularityRating)
VALUES ('Joaquin', 'Phoenix', 'american', '1974-10-28', '32'),
       ('Scarlett', 'Johansson', 'american', '1984-11-22', '34'),
	   ('Tom', 'Hardy', 'english', '1977-09-15', '37'),
	   ('Karen', 'Gillan', 'english', '1987-11-28', '68'),
	   ('Tom', 'Hanks', 'american', '1956-07-09', '98');


--7. Which is the movie with the lowest rating?
SELECT Title, Rating AS LowestRating
FROM Movie
WHERE Rating = (SELECT MIN(Rating) FROM Movie);


--8.Which director has the most movies directed?
SELECT FirstName, LastName
FROM Director d
WHERE (SELECT COUNT(*) FROM Movie m WHERE m.DirectorID = d.DirectorID) > 1;


--9.Display all movies ordered by director's LastName in ascending order, then by birth date descending.
SELECT LastName,Title FROM Director, Movie
WHERE Movie.DirectorID=Director.DirectorID 
ORDER BY LastName; 

SELECT LastName,Birthdate,Title FROM Director, Movie 
WHERE Movie.DirectorID=Director.DirectorID 
ORDER BY Birthdate DESC; 


--10. Create a function that will calculate and return the average rating of movies for a given director id
SELECT 
AVG(Rating) [Average Rating]
FROM Movie
WHERE DirectorID = 4;


--11. Create a view that will display all the movie titles with the directors' first names and last names.
CREATE VIEW [Movie Titles] AS
SELECT Title, FirstName, LastName
FROM Movie, Director
WHERE Movie.DirectorID=Director.DirectorID
SELECT* FROM [Movie Titles]


--12. Create a stored procedure that will increment the rating by 1 for a given movie id.
CREATE PROCEDURE IncrementRating @MovieID int
AS
UPDATE Movie 
SET Rating = Rating + 1 WHERE MovieID = @MovieID
GO
EXEC IncrementRating 2


--13. Create a table called MovieHistory with a column for Id and a column for Message. 
--Create a trigger that will add a new entry in the MovieHistory table when a row from Movie's table is updated.

