;
; СУ "Св. Климент Охридски"
; Факултет по математика и информатика
; Курс Функционално програмиране 2020/21
; Контролно 2
; 2020-12-12
;
; Име: 
; ФН:
; Специалност:
; Курс: 
; Административна група: 
; Начален час на контролното: <тук попълнете часа за вашата група>
;

#lang racket/base

(require "k2.rkt") ; Променете името на файла, който се включва така,
                   ; че тук да се зарежда файлът с вашето решение.
                   ; Например ако файлът с решението ви се казва 12345.rkt,
                   ; променете реда на (require "12345.rkt").

(require rackunit rackunit/gui)

(test/gui

 ; Даденият по-долу пример е само ориентировъчен.
 ; Когато решавате задачите си, можете да го изтриете
 ; или да го промените така, че да проверява условия
 ; свързани с вашия код.
 
 (test-suite
  "sample-function"

  (test-true   "sample test 1" (sample-function #t))
  (test-false  "sample test 2" (sample-function #f))
  (test-equal? "sample test 3" (sample-function 10) 10)
  (test-equal? "sample test 4" (sample-function '(1 2 3)) '(1 2 3))

  (test-case
   "A sample test case, which performs multiple checks"
   (check-true   (sample-function #t))
   (check-false  (sample-function #f))
   (check-equal? (sample-function 10) 10))

 )
 
)
