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
  id int UNIQUE GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name VARCHAR(100),
  age INT
);