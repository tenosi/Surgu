-- Active: 1790276235061@@127.0.0.1@5432@tablebook
CREATE DATABASE tablebook;
CREATE TABLE Reader (
    id_reader INT PRIMARY KEY,
    name_ VARCHAR(100),
    phone INT
);
CREATE TABLE Loan (
    id_loan SERIAL,
    id_reager INT REFERENCES Reader(id_reader),
    id_isbn VARCHAR(100) REFERENCES Book(isbn),
    date_lone DATE,
    plan_date_refund DATE,
    fact_date_regund DATE
);
INSERT into loan VALUES (DEFAULT, 100, 6, '2026-09-22', '2026-10-22', NULL);
INSERT into loan VALUES (DEFAULT, 100, 6, NULL, '2026-10-22', NULL);
CREATE TABLE Book (
    isbn VARCHAR(13) PRIMARY KEY,
    title VARCHAR(100),
    pudlication INT
)

CREATE TABLE Autoship (
    isbn_book VARCHAR(13) REFERENCES Book(isbn),
    id_author INT REFERENCES Author(id_author)
)

CREATE TABLE Author (
    id_author SERIAL PRIMARY KEY,
    name_author VARCHAR(100)
)