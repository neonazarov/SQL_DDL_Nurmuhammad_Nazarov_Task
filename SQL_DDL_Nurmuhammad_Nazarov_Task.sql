-- Create Database
CREATE DATABASE domain_related_database;

-- Connect to the Database
\c domain_related_database;

-- Create Schema
CREATE SCHEMA domain_related_schema;

-- Create Users Table
CREATE TABLE domain_related_schema.Users (
    UserID SERIAL PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    Birthdate DATE CHECK (Birthdate > '2000-01-01'),
    Record_ts DATE DEFAULT current_date
);

-- Create MeasuredValues Table
CREATE TABLE domain_related_schema.MeasuredValues (
    ValueID SERIAL PRIMARY KEY,
    UserID INT REFERENCES domain_related_schema.Users(UserID),
    Value NUMERIC NOT NULL CHECK (Value >= 0),
    MeasurementDate DATE CHECK (MeasurementDate > '2000-01-01'),
    Record_ts DATE DEFAULT current_date
);

-- Insert sample data into Users table
INSERT INTO domain_related_schema.Users (UserName, Gender, Birthdate) VALUES
    ('John Doe', 'M', '2000-05-15'),
    ('Jane Smith', 'F', '1998-10-20');

-- Insert sample data into MeasuredValues table
INSERT INTO domain_related_schema.MeasuredValues (UserID, Value, MeasurementDate) VALUES
    (1, 75.5, '2023-01-15'),
    (2, 62.3, '2023-02-20');

-- Apply CHECK Constraints for Gender and Positive Value
ALTER TABLE domain_related_schema.Users
ADD CONSTRAINT chk_specific_gender CHECK (Gender IN ('M', 'F'));

ALTER TABLE domain_related_schema.MeasuredValues
ADD CONSTRAINT chk_positive_value CHECK (Value >= 0);

-- Create UNIQUE Constraints for UserName and Measurement
ALTER TABLE domain_related_schema.Users
ADD CONSTRAINT unique_username UNIQUE (UserName);

ALTER TABLE domain_related_schema.MeasuredValues
ADD CONSTRAINT unique_measurement UNIQUE (UserID, MeasurementDate);

-- Add 'record_ts' Field to Users Table
ALTER TABLE domain_related_schema.Users
ADD COLUMN record_ts DATE DEFAULT current_date;

-- Add 'record_ts' Field to MeasuredValues Table
ALTER TABLE domain_related_schema.MeasuredValues
ADD COLUMN record_ts DATE DEFAULT current_date;
