-- Active: 1790276235061@@127.0.0.1@5432@hotal
CREATE DATABASE hotal;

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
    room_type VARCHAR(50),
    floor INT,
    price_per_night DECIMAL(10, 2),
    capacity INT,
    room_status VARCHAR(30)
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
    price DECIMAL(10, 2)
);

CREATE TABLE Inventory (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(100),
    category VARCHAR(50),
    quantity_in_stock INT,
    unit_price DECIMAL(10, 2)
);

CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in_date DATE,
    check_out_date DATE,
    total_price DECIMAL(10, 2),
    booking_status VARCHAR(30),
    payment_status VARCHAR(30),
    number_of_guests INT,
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

CREATE TABLE GuestServices (
    usage_id SERIAL PRIMARY KEY,
    guest_id INT,
    service_id INT,
    usage_date DATE,
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

INSERT INTO GuestServices (guest_id, service_id, usage_date) VALUES
(1, 1, '2026-06-02'),
(1, 2, '2026-06-01'),
(2, 3, '2026-06-11');

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

--Имя и услуги которые они использовали
SELECT 
    g.full_name AS client_name, 
    s.service_name, 
    s.price, 
    gs.usage_date
FROM GuestServices gs
JOIN Guests g ON gs.guest_id = g.guest_id
JOIN Services s ON gs.service_id = s.service_id;




