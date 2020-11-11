#lang r5rs
; Задача 1: Да се дефинира функция (revlex-less a b), която проверява дали a е преди b в лексикографска наредба (откъм последния символ)
; Задача 2: Да се дефинира функция (nset-accumulate op term init s), която работи сходно на функцията accumulate, но прилага (op) върху елементите на множеството s
; Задача 3: Да се дефинира функция (nset-revlex-min), която намира най-малкия (според наредбата дефинирана в Задача 1) елемент на множеството s. Ако множеството е празно, функцията да връща #f.
; Задача 4: В даден ресторант постоянно получават заявки за резервации за различни времена от деня и с различна продължителност. За да организират оптимален работен график, трябва да имат информация за най-натоварените части на деня. Да се дефинира функция (find-busiest reservations), която по списък с резервации намира най-натоварения интервал и колко резервации има за него. Резервациите са наредени двойки от естествени числа, сигнализиращи начало и край на резервацията. Резервации с начало не по-малко от края считаме за невалидни.
; Задача 5: Да се дефинира функция (zip-with op l1 l2), която връща списък с елементи равни на резултата от прилагането на (op) върху съответните елементи на l1 и l2. Резултатния списък трябва да е с дължина колкото минимума от дължините на двата списъка, подадени като аргумент.
; Задача 5*: Да се дефинира функция (scalar-mult v1 v2), която намира скаларното произведение на векторите v1 и v2
; Задача 6: Да се дефинира функция (flatten-deep lss), която от произволен списък (чиито елементи може да са списъци, техните елементи също може да са списъци и т.н.) връща един-единствен списък с елементите, срещани в списъците lss