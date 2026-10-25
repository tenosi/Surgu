-- Active: 1790276235061@@127.0.0.1@5432@normall

CREATE DATABASE normall;
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255)
);
CREATE TABLE Workers (
    workers_id INT PRIMARY KEY,
    full_name VARCHAR(255)
);

INSERT INTO Projects (project_id, project_name) VALUES
(1, 'Пишет конспект'),
(2, 'Создает базу данных'),
(3, 'Проверяет базу данных');

INSERT INTO Workers (workers_id, full_name) VALUES
(1, 'Гадыев Ильвир'),
(2, 'Кибак Никита'),
(3, 'Георгий Куценко');

CREATE TABLE Connection (
    project_id INT,
    workers_id INT,
    PRIMARY KEY (project_id, workers_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (workers_id) REFERENCES Workers(workers_id)
);

INSERT INTO Connection (project_id, workers_id) VALUES
(1, 1),
(1, 2),
(3, 3),
(2, 2);

SELECT p.project_name, w.full_name FROM Projects p
JOIN Connection co ON p.project_id = co.project_id
JOIN Workers w ON co.workers_id = w.workers_id
WHERE p.project_id = 2;

--Нарушение атомарности, из-за того, что изначально в строке было много имен через запятую, не получилось бы взять какого-то определённого человека.


CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(255),
    client_email VARCHAR(255)
);

CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(255)
);

INSERT INTO Clients (client_id, client_name, client_email) VALUES
(1, 'Гадыев Ильвир', 'gadyev02@mail.ru'),
(2, 'Кибак Никита', 'kibak@mail.ru'),
(3, 'Георгий Куценко', 'Goga@mail.ru');

INSERT INTO Equipment (equipment_id, equipment_name) VALUES
(1, 'Ручка'),
(2, 'Компьютер'),
(3, 'Телефон');

CREATE TABLE Rentals (
    client_id INT,
    equipment_id INT,
    rental_date DATE,
    PRIMARY KEY (client_id, equipment_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

INSERT INTO Rentals (client_id, equipment_id, rental_date) VALUES
(1, 1, '2026-09-27'),
(1, 2, '2026-10-02'),
(2, 2, '2026-10-18'),
(2, 3, '2026-10-21');


SELECT cl.client_name, cl.client_email, eq.equipment_name, r.rental_date FROM Rentals r
JOIN Clients cl ON r.client_id = cl.client_id
JOIN Equipment eq ON r.equipment_id = eq.equipment_id;

--Избыточность, аномалия обновления, частичная зависимость. Из-за того, что у нас была одна большая таблица, нам было бы не удобно работать с ней.
--Чтобы добавить что-то новое или изменить, пришлось бы переписывать полностю строку



--Ответ: атомарные (неделимым) в одной ячейке не может храниться несколько значений.
CREATE TABLE StudentGrades (
    student_id INT,
    course_id INT,
    assignment_name VARCHAR(255),
    student_name VARCHAR(255),
    course_professor VARCHAR(255),
    grade INT,
    PRIMARY KEY (student_id, course_id, assignment_name)
);

INSERT INTO StudentGrades (student_id, course_id, assignment_name, student_name, course_professor, grade) VALUES
(1, 1, 'Информатика', 'Гадыев Ильвир', 'Нина Борисовна', 85),
(1, 1, 'Математика', 'Гадыев Ильвир', 'Антон Георгиевич', 92),
(1, 2, 'История', 'Гадыев Ильвир', 'Юлия Константиновна', 88),
(2, 1, 'Информатика', 'Кибак Никита', 'Нина Борисовна', 95),
(2, 1, 'Математика', 'Кибак Никита', 'Антон Георгиевич', 90);

SELECT * FROM StudentGrades WHERE student_id = 2;


CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255)
);
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_professor VARCHAR(255)
);
CREATE TABLE StudentGrades_ (
    student_id INT,
    course_id INT,
    assignment_name VARCHAR(255),
    grade INT,
    PRIMARY KEY (student_id, course_id, assignment_name),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students (student_id, student_name) VALUES
(1, 'Гадыев Ильвир'),
(2, 'Кибак Никита');

INSERT INTO Courses (course_id, course_professor) VALUES
(1, 'Нина Борисовна'),
(2, 'Юлия Константиновна'),
(3, 'Антон Георгиевич')

INSERT INTO StudentGrades_ (student_id, course_id, assignment_name, grade) VALUES
(1, 1, 'Информатика', 85),
(1, 1, 'Математика', 92),
(1, 2, 'История', 88),
(2, 1, 'Информатика', 95),
(2, 1, 'Математика', 90);
