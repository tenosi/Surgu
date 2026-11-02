-- Active: 1790276235061@@127.0.0.1@5432@hosss

CREATE DATABASE hosss;

CREATE TABLE Guests (
    guest_id SERIAL PRIMARY KEY,
    full_name VARCHAR(200),
    email VARCHAR(150),
    phone_number VARCHAR(20),
    date_of_birth DATE
);

CREATE TABLE Rooms (
    room_id SERIAL PRIMARY KEY,
    room_number VARCHAR(10),
    room_type VARCHAR(20) CHECK (room_type IN ('Эконом', 'Стандарт', 'Люкс')),
    floor INT,
    price_per_night MONEY,
    capacity INT,
    room_status VARCHAR(30) CHECK (room_status IN ('Свободен', 'Занят'))
);


CREATE TABLE Staff (
    staff_id SERIAL PRIMARY KEY,
    full_name VARCHAR(200),
    position VARCHAR(100),
    hire_date DATE,
    phone_number VARCHAR(20)
);


CREATE TABLE Services (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100),
    service_category VARCHAR(50),
    price MONEY
);


CREATE TABLE Inventory (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(100),
    category VARCHAR(50),
    quantity_in_stock INT,
    unit_price MONEY
);


CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in_date DATE,
    check_out_date DATE,
    total_price MONEY,
    booking_status VARCHAR(20) CHECK (booking_status IN ('Подтверждено', 'Ожидание')),
    payment_status VARCHAR(30) CHECK (payment_status IN ('Оплачено', 'Предоплата', 'Ожидание')),
    number_of_guests INT,
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);


CREATE TABLE GuestServices (
    usage_id SERIAL PRIMARY KEY,
    guest_id INT,
    service_id INT,
    usage_date DATE,
    price MONEY NOT NULL, 
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

INSERT INTO GuestServices (guest_id, service_id, usage_date, price) VALUES
(1, 1, '2026-06-02', '3500.00'),
(1, 2, '2026-06-01', '1500.00'),
(2, 3, '2026-06-11', '2000.00');

INSERT INTO Guests (full_name, email, phone_number, date_of_birth) VALUES
('Гадыев Ильвир', 'gadyev02@mail.ru', '+79224022512', '2008-04-07'),
('Кибак Никита', 'kibak@mail.ru', '+79994445566', '2008-01-04'),
('Георгий Куценко', 'Goga@mail.ru', '+79993332211', '2003-07-20');

INSERT INTO Rooms (room_number, room_type, floor, price_per_night, capacity, room_status) VALUES
('301', 'Люкс', 3, 15000.00, 2, 'Свободен'),
('205', 'Стандарт', 2, 5000.00, 1, 'Занят'),
('102', 'Эконом', 1, 3000.00, 2, 'Свободен');

INSERT INTO Staff (full_name, position, hire_date, phone_number) VALUES
('Мария Мариновна', 'Администратор', '2023-01-15', '+79999999999'),
('Иван Иванов', 'Повар', '2022-11-01', '+799999992');

INSERT INTO Services (service_name, service_category, price) VALUES
('СПА-массаж', 'Релаксация', 3500.00),
('Трансфер из аэропорта', 'Транспорт', 2000.00),
('Завтрак', 'Питание', 800.00);

INSERT INTO Inventory (item_name, category, quantity_in_stock, unit_price) VALUES
('Полотенце махровое', 'Текстиль', 150, 500.00),
('Мыло отельное', 'Косметика', 500, 45.50),
('Фен настенный', 'Электроника', 25, 2500.00);

INSERT INTO Bookings (guest_id, room_id, check_in_date, check_out_date, total_price, booking_status, payment_status, number_of_guests) VALUES
(1, 2, '2026-06-01', '2026-06-05', 20000.00, 'Подтверждено', 'Оплачено', 1),
(2, 1, '2026-06-10', '2026-06-15', 75000.00, 'Подтверждено', 'Предоплата', 2);

--Имя клиента и номер 
SELECT 
    g.full_name AS client_name, 
    r.room_number 
FROM Bookings b
JOIN Guests g ON b.guest_id = g.guest_id
JOIN Rooms r ON b.room_id = r.room_id;

--Номер и статус 
SELECT room_number, room_status 
FROM Rooms;

--Исправил цены и их возможность на корректировки цен

UPDATE Services 
SET price = 5000.00 
WHERE service_id = 1;

UPDATE Services 
SET price = 1200.00 
WHERE service_id = 3;

SELECT service_id, service_name, price AS current_price_in_catalog 
FROM Services;

SELECT gs.usage_id, g.full_name, s.service_name, gs.usage_date, gs.price AS price_paid_by_guest
FROM GuestServices gs
JOIN Guests g ON gs.guest_id = g.guest_id
JOIN Services s ON gs.service_id = s.service_id;

SELECT guest_id, SUM(price) AS total_spent_by_guest 
FROM GuestServices 
WHERE guest_id = 1 
GROUP BY guest_id;

