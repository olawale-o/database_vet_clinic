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

-- BELOW IS THE TRANSACTION REQUIREMENTS FOR THE PROJECT 

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before tranasction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)
SELECT * FROM animals;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN;
SAVEPOINT ANIMALS_BORN_AFTER_2022_01_01;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
UPDATE animals SET weight_kg = (-1 * weight_kg);
ROLLBACK TO SAVEPOINT ANIMALS_BORN_AFTER_2022_01_01;
UPDATE animals SET weight_kg = (-1 * weight_kg) WHERE weight_kg < 0;
COMMIT;

-- Vet clinic database: query multiple tables

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT animals.*, owners.full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
-- Ans: Squirtle, Charmander, Blossom

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id |  full_name  
-- ----+------------+---------------+-----------------+----------+-----------+------------+----------+-------------
--   7 | Squirtle   | 1993-04-02    |               3 | f        |   12.1300 |          1 |        4 | Melody Pond
--   5 | Charmander | 2020-02-08    |               0 | f        |   11.0000 |          1 |        4 | Melody Pond
--  10 | Blossom    | 1998-10-13    |               3 | t        |   17.0000 |          1 |        4 | Melody Pond


-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.*, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
-- Ans:
   -- Squirtle
   -- Charmander
   -- Blossom
   -- Pikachu
--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id |  name   
-- ----+------------+---------------+-----------------+----------+-----------+------------+----------+---------
--   7 | Squirtle   | 1993-04-02    |               3 | f        |   12.1300 |          1 |        4 | Pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |   11.0000 |          1 |        4 | Pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |   17.0000 |          1 |        4 | Pokemon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |   15.0400 |          1 |        2 | Pokemon

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.* FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;
--     full_name    | id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id 
-- -----------------+----+------------+---------------+-----------------+----------+-----------+------------+----------
--  Sam Smith       |  1 | Agumon     | 2020-02-03    |               0 | t        |   10.2300 |          2 |        1
--  Jennifer Orwell |  3 | Pikachu    | 2021-01-07    |               1 | f        |   15.0400 |          1 |        2
--  Jennifer Orwell |  2 | Gabumon    | 2018-11-15    |               2 | t        |    8.0000 |          2 |        2
--  Bob             |  6 | Plantmon   | 2022-11-15    |               2 | t        |    5.7000 |          2 |        3
--  Bob             |  4 | Devimon    | 2017-05-12    |               5 | t        |   11.0000 |          2 |        3
--  Melody Pond     |  7 | Squirtle   | 1993-04-02    |               3 | f        |   12.1300 |          1 |        4
--  Melody Pond     |  5 | Charmander | 2020-02-08    |               0 | f        |   11.0000 |          1 |        4
--  Melody Pond     | 10 | Blossom    | 1998-10-13    |               3 | t        |   17.0000 |          1 |        4
--  Dean Winchester |  8 | Angemon    | 2005-06-12    |               1 | t        |   45.0000 |          2 |        5
--  Dean Winchester |  9 | Boarmon    | 2005-06-07    |               7 | t        |   20.4000 |          2 |        5
--  Jodie Whittaker |    |            |               |                 |          |           |            |     

-- How many animals are there per species?
SELECT COUNT(species_id) AS species, species.name FROM animals
INNER JOIN species ON animals.species_id = species.id GROUP BY species_id, species.name;
-- Ans: 6 and 4
--  species |  name   
-- ---------+---------
--        6 | Digimon
--        4 | Pokemon

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.*, species.name, owners.full_name
FROM animals INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owner.full_name = 'Jennifer Orwell';
-- Ans: Gabumon
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id |  name   |    full_name    
-- ----+---------+---------------+-----------------+----------+-----------+------------+----------+---------+-----------------
--   2 | Gabumon | 2018-11-15    |               2 | t        |    8.0000 |          2 |        2 | Digimon | Jennifer Orwell

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.*, owners.full_name
FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE
owners.full_name = 'Dean Winchester' AND animals.escape_attempts < 1;
-- Ans: 0
-- All animals owned by Dean Wincheste have tried to escape
--  id | name | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id | full_name 
-- ----+------+---------------+-----------------+----------+-----------+------------+----------+-----------

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.owner_id) AS no_of_animals FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY animals.owner_id, owners.full_name ORDER BY no_of_animals DESC LIMIT 1;
-- Ans: Melody Pond
--   full_name  | no_of_animals 
-- -------------+---------------
--  Melody Pond |             3


-- Vet clinic database: add "join table" for visits

-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT visits.*, vets.name, animals.name AS animal FROM vets
INNER JOIN visits
ON visits.vets_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'William Tatcher' ORDER BY date_of_the_visit DESC
LIMIT 1;
-- Ans: Blossom
--  id | animal_id | vets_id | date_of_the_visit |      name       | animal  
-- ----+-----------+---------+-------------------+-----------------+---------
--  20 |        10 |       1 | 2021-01-11        | William Tatcher | Blossom

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.species_id) FROM animals
INNER JOIN (SELECT visits.*, vets.name FROM visits
INNER JOIN vets
ON visits.vets_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez') AS INNER_TABLE
ON animals.id  = INNER_TABLE.animal_id;
-- Ans: 4
--  count 
-- -------
--      4

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, specializations.species_id, specializations.vets_id,
species.name AS species FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vets_id
LEFT JOIN species
ON specializations.species_id = species.id;
-- Ans:
--        name       | species_id | vets_id | species 
-- ------------------+------------+---------+---------
--  William Tatcher  |          1 |       1 | Pokemon
--  Stephanie Mendez |          2 |       3 | Digimon
--  Stephanie Mendez |          1 |       3 | Pokemon
--  Jack Harkness    |          2 |       4 | Digimon
--  Maisy Smith      |            |         | 

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT visits.date_of_the_visit, animals.name AS animal, vets.name AS vet FROM visits
INNER JOIN animals
ON visits.animal_id = animals.id
INNER JOIN vets
ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_the_visit BETWEEN '2020-04-01' AND '2020-08-30';
-- Ans: Agumon and Blossom

--  date_of_the_visit | animal  |       vet        
-- -------------------+---------+------------------
--  2020-07-22        | Agumon  | Stephanie Mendez
--  2020-05-24        | Blossom | Stephanie Mendez

-- What animal has the most visits to vets?
SELECT COUNT(visits.animal_id) as no_of_visits, animals.name AS animal FROM
visits 
INNER JOIN animals
ON visits.animal_id = animals.id
GROUP BY animals.name ORDER BY no_of_visits DESC LIMIT 1;
-- Ans: Boarmon
--  no_of_visits |  animal   
-- --------------+---------
--   4 | Boarmon

-- Who was Maisy Smith's first visit?
SELECT visits.*, vets.name, animals.name AS animal FROM vets
INNER JOIN visits
ON visits.vets_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_the_visit
LIMIT 1;
-- Ans Boarmon:
--  id | animal_id | vets_id | date_of_the_visit |    name     | animal  
-- ----+-----------+---------+-------------------+-------------+---------
--  15 |         9 |       2 | 2019-01-24        | Maisy Smith | Boarmon

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT visits.date_of_the_visit, vets.*, animals.* AS animal FROM vets
INNER JOIN visits
ON visits.vets_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
ORDER BY visits.date_of_the_visit DESC LIMIT 1;
-- Ans:
--  date_of_the_visit | id |       name       | age | date_of_graduation | id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id 
-- -------------------+----+------------------+-----+--------------------+----+---------+---------------+-----------------+----------+-----------+------------+----------
--  2021-05-04        |  3 | Stephanie Mendez |  64 | 1981-05-04         |  4 | Devimon | 2017-05-12    |               5 | t        |   11.0000 |          2 |        3

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animal_id) FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animal_id
INNER JOIN specializations ON specializationS.vets_id = vets.id
WHERE specializations.species_id != animals.species_id;
-- Ans:
--  count 
-- -------
--      7

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
--Ans: Maisy Smith should consider getting Digimon specialist
SELECT  COUNT(animals.species_id), species.name AS species FROM vets
INNER JOIN visits
ON visits.vets_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
INNER JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith' GROUP BY species.name LIMIT 1;
--  count | species 
-- -------+---------
--      6 | Digimon
