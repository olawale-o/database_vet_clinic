/* Database schema to keep the structure of entire database. */

-- Milestone: Vet clinic database: create animals table

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
  id int UNIQUE PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth date,
  escape_attempts int,
  neutered BOOLEAN DEFAULT false,
  weight_kg decimal(10,4)
);

-- Milestone: Vet clinic database: query and update animals table

ALTER TABLE animals ADD species VARCHAR(100);

-- Vet clinic database: query multiple tables

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer

CREATE TABLE owners (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(100),
  age INT,
  PRIMARY KEY(id)
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string

CREATE TABLE species (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  PRIMARY KEY(id)
);

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
ALTER TABLE animals DROP species;
ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT, ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

-- Vet clinic database: add "join table" for visits

-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date

CREATE TABLE vets (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  age INT,
  date_of_graduation date,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  species_id INT,
  vets_id INT,
  PRIMARY KEY(id),
  CONSTRAINT fk_species
  FOREIGN KEY(species_id)
  REFERENCES species(id),
  CONSTRAINT fk_vets
  FOREIGN KEY(vets_id)
  REFERENCES vets(id)
);

CREATE TABLE visits (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  animal_id INT,
  vets_id INT,
  date_of_the_visit date,
  PRIMARY KEY(id),
  CONSTRAINT fk_animals
  FOREIGN KEY(animal_id)
  REFERENCES animals(id),
  CONSTRAINT fk_vets
  FOREIGN KEY(vets_id)
  REFERENCES vets(id)
);

-- Vet clinic database: database performance audit

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX idx_visits_animal_id ON visits (animal_id);
CREATE INDEX idx_visits_vets_id ON visits (vets_id);

CREATE INDEX idx_owners_email ON owners (email);

-- Create a database based on a diagram
CREATE DATABASE clinic;

CREATE TABLE patients (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE,
  PRIMARY KEY (id)
);