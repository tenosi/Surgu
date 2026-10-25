CREATE DATABASE tableNume;
CREATE TABLE Reader (
    id_reader SERIAL PRIMARY KEY,
    name_ VARCHAR(100),
    phone VARCHAR
);

INSERT INTO Reader (name_, phone)
VALUES ('Гадыев Ильвир', '+7-922-402-25-12'),
('Никита Кибак', '+7-922-543-62-26'),
('Георгий Куценко', '+7-922-837-53-27'),
('Лисовский Андрей', '+7-922-543-23-56'),
('Штрауб Денис', '+7-922-922-92-98');


CREATE TABLE Book (
    isbn VARCHAR (100) PRIMARY KEY,
    title VARCHAR(100),
    pudlication INT
);

INSERT INTO Book (isbn, title, pudlication) VALUES
('978-5-17-150826-3', '«Твоё сердце будет разбито»', '2022'),
('978-5-389-22196-3', '«Крутой маршрут»', '1977'),
('978-5-17-118866-6', '«Понедельник начинается в субботу»', '1964'),
('978-5-389-25627-9', '«Два капитана»', '1940'),
('978-5-17-146629-9', '«Двенадцать стульев»', '1928'),
('978-5-17-136979-6', '«Время ночь»', '1991');


CREATE TABLE Author (
    id_author SERIAL PRIMARY KEY,
    name_author VARCHAR(100)
);

INSERT INTO Author (name_author)
VALUES ('Анна Джейн'),
('Евгения Гинзбург'),
('Вениамин Каверин'),
('Людмила Петрушевская'),
('Аркадий и Борис Стругацкие'),
('Илья Ильф и Евгений Петров');

CREATE TABLE Loan (
    id_loan SERIAL,
    id_reager SERIAL REFERENCES Reader(id_reader),
    id_isbn VARCHAR(100) REFERENCES Book(isbn),
    date_lone DATE,
    plan_date_refund DATE,
    fact_date_regund DATE
);

INSERT INTO Loan (id_reager, id_isbn, date_lone, plan_date_refund, fact_date_regund) VALUES 
('1', '978-5-17-150826-3', '2026-07-07', '2026-07-09', '2026-07-13'),
('2','978-5-389-22196-3', '2026-07-09', '2026-07-13', '2026-08-14'),
('3','978-5-17-118866-6', '2026-07-13', '2026-07-25', NULL),
('4','978-5-389-25627-9', '2026-07-25', '2026-08-03', NULL),
('5','978-5-17-146629-9', '2026-08-04', '2026-08-14', '2026-08-28');

CREATE TABLE Autoship (
    isbn_book VARCHAR(30) REFERENCES Book(isbn),
    id_author INT REFERENCES Author(id_author)
);

INSERT INTO Autoship (isbn_book, id_author)
VALUES ('978-5-17-150826-3', '1'),
('978-5-389-22196-3','2'),
('978-5-17-118866-6','3'),
('978-5-389-25627-9','4'),
('978-5-17-146629-9','5'),
('978-5-17-136979-6','6');


SELECT * FROM Reader;
--Задание 1: Вывести полный список читателей

SELECT title, pudlication FROM Book;
--Задание 2: Вывести названия книг и годы издания

SELECT pudlication, title FROM Book WHERE pudlication > 2021;
--Задание 3: Найти книги XIX века

SELECT pudlication, title FROM Book WHERE pudlication BETWEEN 1917 and 1991;
--Задание 4: Найти книги советского периода

SELECT name_, phone FROM Reader WHERE phone IN ('+7-922-402-25-12', '+7-922-543-62-26');
--Задание 5: Найти читателя по номеру телефона

SELECT name_, phone FROM Reader WHERE name_ LIKE '%ак';
--Задание 6: Найти читателей по фрагменту ФИО

SELECT * FROM Loan WHERE fact_date_regund IS NULL;
--Задание 7: Найти активные выдачи

SELECT * FROM Book ORDER BY title;
--Задание 8: Отсортировать книги по названию

SELECT * FROM Loan ORDER BY plan_date_refund ASC;
--Задание 9: Показать ближайшие плановые возвраты

SELECT * FROM Book ORDER BY title ASC LIMIT 3;
--Задание 10: Найти ограниченный набор книг. Первые по алфавиту.ACCESS
