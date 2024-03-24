CREATE DATABASE LibraryManagement;


CREATE SCHEMA LibraryData;

CREATE TABLE LibraryData.Books (
    BookID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    PublicationDate DATE CHECK (PublicationDate > '2000-01-01'),
    Genre VARCHAR(50) NOT NULL,
    Price DECIMAL CHECK (Price > 0),
    AuthorID INTEGER 
);


CREATE TABLE LibraryData.Authors (
    AuthorID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Birthdate DATE NOT NULL,
    Gender VARCHAR(50) CHECK (Gender IN ('Male', 'Female', 'Other'))
);


ALTER TABLE LibraryData.Books
ADD CONSTRAINT FK_Book_Author
FOREIGN KEY (AuthorID)
REFERENCES LibData.Authors (AuthorID);


INSERT INTO LibraryData.Books (Title, PublicationDate, Genre, Price) VALUES ('The Great Gatsby', '2020-04-10', 'Classic', 19.99);


ALTER TABLE LibraryData.Books ADD COLUMN record_ts DATE DEFAULT CURRENT_DATE;


SELECT * FROM LibraryData.Books;
