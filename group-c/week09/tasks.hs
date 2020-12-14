{-
Welcome to Haskell!

основни операции с числа:
    +, -, *, /
    ^, **
    div, mod (quot); backtick

логически оператори:
     <, <=, ==, >=, >, /=
    &&, ||, not

математически функции
    sqrt, ceil, floor, round

control flow:
    if ... then ... else ...
    let ... in ...
    guards

типове:
    *Int, Integer, Float, Double, Bool, Char, String (== [Char]), списък

списъци:
    head, tail, : (cons), ++ (append)
    вградени функции - map, filter, foldl, foldr, zipWith, elem
    * range (with step)
    * list comprehension!
-}

-- Примери:

divides :: Int -> Int -> Bool
divides x y = undefined

hypotenuse :: Float -> Float -> Float
hypotenuse x y = undefined

clamp :: (Ord a) => a -> a -> a -> a
clamp x y z = undefined

factorial :: Int -> Int
factorial n = undefined

-- Задача 1: Да се реализира функцията max x y z, която връща най-голямото от 3 числа
max :: Int -> Int -> Int -> Int
max x y z = undefined

-- Задача 2: Да се реализира функцията fib n, която връща n-тото число на Фибоначи
fib :: Int -> Int
fib n = undefined

-- Задача 3: Да се реализира функция isPalindrome n, която проверява дали n е палиндром
isPalindrome :: Integer -> Bool
isPalindrome n = undefined

-- Задача 4: Да се реализира функция isPrime n, която проверява дали n е просто число
isPrime :: Integer -> Bool
isPrime n = undefined
