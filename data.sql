/* Populate database with sample data. */

-- Milestone: Vet clinic database: create animals table

-- Animal: His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);
-- Animal: Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
-- Animal: His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
-- Animal: Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);

-- Milestone: Vet clinic database: query and update animals table

-- Animal: His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (5, 'Charmander', '2020-02-08', 0, false, -11);
-- Animal: Her name is Plantmon. She was born on Nov 15th, 2022, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (6, 'Plantmon', '2022-11-15', 2, true, -5.7);
-- Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to 3 times.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);
-- Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (8, 'Angemon', '2005-06-12', 1, true, -45);
-- Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);
-- Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (10, 'Blossom', '1998-10-13', 3, true, 17);


-- Vet clinic database: query multiple tables

-- Insert the following data into the owners table:
-- Sam Smith 34 years old.
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
-- Jennifer Orwell 19 years old.
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
-- Bob 45 years old.
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
-- Melody Pond 77 years old.
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
-- Dean Winchester 14 years old.
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
-- Jodie Whittaker 38 years old.
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Insert the following data into the species table:
-- Pokemon
INSERT INTO species(name) VALUES('Pokemon');
-- Digimon
INSERT INTO species(name) VALUES('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE animals SET species_id = CASE
WHEN name LIKE '%mon' THEN 2
ELSE 1
END;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';

-- Vet clinic database: add "join table" for visits

BEGIN;
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
INSERT INTO vets(name, age, date_of_graduation) VALUES('William Tatcher', 45, '2000-04-23');
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
INSERT INTO vets(name, age, date_of_graduation) VALUES('Maisy Smith', 26, '2019-01-17');
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
INSERT INTO vets(name, age, date_of_graduation) VALUES('Stephanie Mendez', 64, '1981-05-04');
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets(name, age, date_of_graduation) VALUES('Jack Harkness', 38, '2008-06-08');
COMMIT;

-- Insert the following data for specialties:
BEGIN;
-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO specializations(species_id, vets_id) VALUES(1, 1);
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations(species_id, vets_id) VALUES(2, 3);
INSERT INTO specializations(species_id, vets_id) VALUES(1, 3);
-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations(species_id, vets_id) VALUES(2, 4);
ROLLBACK;