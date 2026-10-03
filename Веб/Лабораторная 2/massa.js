/* 1) Проверка числа
Написать функцию checkNumber(number), которая определяет: число положительное, 
отрицательное или ноль; чётное оно или нечётное.*/

function checkNumber(num) {
    if (num<0){
        console.log('Отрицательное');
    }
    if (num>0){
        console.log('Положительное');
    }
    if (num===0){
        console.log('0')
    }
}
checkNumber(283);
checkNumber(-532);
checkNumber(0); 

/*2) Работа с массивом
Дан массив: const numbers = [4, 8, 15, 16, 23, 42];
Найти сумму элементов, самое большое число и создать новый массив 
только из чисел больше 10. Желательно сначала решить через цикл, 
затем через методы массивов.*/

const number= [9,23,46,52,37,75]
let sum = 0
let max = number[0]
let a = []
for (let i = 0; i<6; i++) {
    sum = sum + number[i]
    if (number[i]> max) {
        max = number[i]
    }
    if (number[i]>10) {
        a.push(number[i])
    }
}

console.log(sum);
console.log(max);
console.log(a);

/*3) Список учеников
Создать массив объектов с полями name и grade. Написать код,
который выводит учеников с оценкой выше заданной
и считает среднюю оценку.*/

const students = [
    {name: "Ильвир", grade: 5},
    {name: "Никита", grade: 3},
    {name: "Георгий", grade: 4},
    {name: "Денис", grade: 2},
    {name: "Андрей", grade: 5}
];
const cool=4;
let summ = 0;
for (let i = 0; i<students.length; i++) {
    let student = students[i];
    if (student.grade >= cool) {
        console.log(student.name);
    }
     if (student) {
        summ = summ + student.grade;
    }
}
let summa = summ / students.length;

console.log(summ);
console.log(summa);

/* 4*) Угадай число
Компьютер выбирает случайное число от 1 до 10. Пользователь вводит вариант,
 а программа сообщает: угадал, загаданное число больше или меньше.
  Это хорошая практика Math.random(), условий и функций.*/

const randomNumber = Math.floor(Math.random() * 10) + 1;
function checkGuess(guess, randomNumber) {
    let flag = 0;
    while(flag!=1){
        if (guess === randomNumber) {
            flag = 1
            return "Правильно";
        } else if (guess < randomNumber) {
            return "Загаданное число больше";
        } else {
            return "Загаданное число меньше";
        }
    }
}
console.log("Случайное число -", randomNumber);
console.log("Проверить число 2-", checkGuess(2, randomNumber));
console.log("Проверить число 6-", checkGuess(6, randomNumber));
