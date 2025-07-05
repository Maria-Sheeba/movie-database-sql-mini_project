
-- Movie Database SQL Project
-- Step 1: Create Tables

CREATE DATABASE IF NOT EXISTS movie_db;
USE movie_db;

CREATE TABLE genres (
  genre_id INT PRIMARY KEY,
  genre_name VARCHAR(50)
);

CREATE TABLE movies (
  movie_id INT PRIMARY KEY,
  title VARCHAR(100),
  release_year INT,
  genre_id INT,
  rating DECIMAL(3,1),
  FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE directors (
  director_id INT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE movie_directors (
  movie_id INT,
  director_id INT,
  PRIMARY KEY (movie_id, director_id),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN KEY (director_id) REFERENCES directors(director_id)
);

-- Step 2: Insert Sample Data

INSERT INTO genres VALUES
(1, 'Sci-Fi'), (2, 'Drama'), (3, 'Comedy'), (4, 'Action');

INSERT INTO movies VALUES
(1, 'Inception', 2010, 1, 8.8),
(2, 'The Dark Knight', 2008, 4, 9.0),
(3, 'Interstellar', 2014, 1, 8.6),
(4, 'The Godfather', 1972, 2, 9.2),
(5, 'Superbad', 2007, 3, 7.6);

INSERT INTO directors VALUES
(1, 'Christopher Nolan'),
(2, 'Francis Ford Coppola'),
(3, 'Greg Mottola');

INSERT INTO movie_directors VALUES
(1, 1), (2, 1), (3, 1), (4, 2), (5, 3);

-- Step 3: Analysis Queries

-- 1. List all movies with genre names
SELECT m.title, g.genre_name, m.rating
FROM movies m
JOIN genres g ON m.genre_id = g.genre_id;

-- 2. Top 3 highest-rated movies
SELECT title, rating
FROM movies
ORDER BY rating DESC
LIMIT 3;

-- 3. Count of movies by genre
SELECT g.genre_name, COUNT(*) AS total_movies
FROM movies m
JOIN genres g ON m.genre_id = g.genre_id
GROUP BY g.genre_name;

-- 4. Average rating by director
SELECT d.name AS director_name, ROUND(AVG(m.rating), 2) AS avg_rating
FROM directors d
JOIN movie_directors md ON d.director_id = md.director_id
JOIN movies m ON m.movie_id = md.movie_id
GROUP BY d.name;

-- 5. Movies released after 2010
SELECT title, release_year
FROM movies
WHERE release_year > 2010;

-- 6. Directors with more than 2 movies
SELECT d.name, COUNT(*) AS movie_count
FROM directors d
JOIN movie_directors md ON d.director_id = md.director_id
GROUP BY d.name
HAVING COUNT(*) > 2;
