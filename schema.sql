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