/*Queries that provide answers to the questions from all projects.*/

-- Milestone: Vet clinic database: create animals table

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT id, name, date_of_birth, neutered, escape_attempts, date_of_birth, weight_kg FROM
  (SELECT *, EXTRACT(YEAR FROM date_of_birth) AS year FROM animals) 
  AS INNER_TABLE WHERE year BETWEEN 2016 and 2019;

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Milestone: Vet clinic database: query and update animals table

-- How many animals are there?
SELECT COUNT(id) FROM animals;
-- Ans: 10

-- How many animals have never tried to escape?
SELECT COUNT(id) FROM animals WHERE escape_attempts < 1;
-- Ans: 2

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Ans: 15.55

-- Who escapes the most, neutered or not neutered animals?
SELECT * FROM animals WHERE neutered = true OR neutered = false ORDER BY escape_attempts DESC LIMIT 1;
-- Ans: Boarmon

-- What is the minimum and maximum weight of each type of animal?
SELECT neutered, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY neutered;
-- Ans:
--  neutered |   min   |   max   
-- ----------+---------+---------
--  f        | 11.0000 | 15.0400
--  t        |  5.7000 | 45.0000

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts), neutered FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) between 1990 AND 2000 GROUP BY neutered;
--  avg | neutered 
-- ---+----------
--  3.0 | f
--  3.0 | t
