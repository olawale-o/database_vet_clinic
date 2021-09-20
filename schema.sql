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