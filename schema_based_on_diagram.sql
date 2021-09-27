-- Create a database based on a diagram
CREATE DATABASE clinic;

CREATE TABLE patients (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(100),
  CONSTRAINT fk_patients
  FOREIGN KEY(patient_id)
  REFERENCES patients(id),
  PRIMARY KEY(id)
);

CREATE INDEX idx_medical_histories_patent_id ON medical_histories(patient_id);

CREATE TABLE treatments (
id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
type VARCHAR(100),
name VARCHAR(100),
PRIMARY KEY(id)
); 