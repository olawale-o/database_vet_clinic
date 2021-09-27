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

CREATE TABLE invoices (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL(10, 2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT fk_medical_histories
  FOREIGN KEY(medical_history_id)
  REFERENCES medical_histories(id),
  PRIMARY KEY(id)
); 

CREATE INDEX idx_invoices_medical_history_id ON invoices(medical_history_id); 

CREATE TABLE invoice_items (
  id INT UNIQUE GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL(10, 2),
  quantity INT,
  total_price DECIMAL(10, 2),
  invoice_id INT,
  treatment_id INT, 
  CONSTRAINT fk_invoices
  FOREIGN KEY(invoice_id)
  REFERENCES invoices(id),
  CONSTRAINT fk_treatments
  FOREIGN KEY(treatment_id)
  REFERENCES treatments(id),
  PRIMARY KEY(id)
);

CREATE INDEX idx_invoice_items_invoice_id ON invoice_items(invoice_id ASC);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items(treatment_id ASC);

CREATE TABLE medical_history_treatment (
  medical_history_id INT,
  treatment_id INT,
  CONSTRAINT fk_medical_histories
  FOREIGN KEY(medical_history_id)
  REFERENCES medical_histories(id),
  CONSTRAINT fk_treatments
  FOREIGN KEY(treatment_id)
  REFERENCES treatments(id)
);

CREATE INDEX idx_medical_history_treatment_medical_history_id ON medical_history_treatment(medical_history_id);

CREATE INDEX idx_medical_history_treatment_treatment_id ON medical_history_treatment(treatment_id);