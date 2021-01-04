{-
Welcome to Haskell!

инструменти за работа:
    - GHC за Windows: https://www.haskell.org/downloads/
    - Visual Studio Code

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
    *guards

типове:
    *Int, Integer, Float, Double, Bool (True, False)
    *Char ('a'), String("this is a string") (== [Char]), списък

списъци:
    head, tail, : (cons), ++ (append)
    вградени функции - map, filter, foldl, foldr, zipWith, elem
    * range (with step)
    * list comprehension!
-}

-- Примери:

divides :: Int -> Int -> Bool
divides x y = y `mod` x == 0

-- c^2 = a^2 + b^2
hypotenuse :: Float -> Float -> Float
hypotenuse x y = sqrt (x^2 + y^2)

-- guards: | <condition> = <expr>
clamp :: (Ord a) => a -> a -> a -> a
clamp x y z
    | x <= y && x >= z || x <= z && x >= y = x
    | y <= x && y >= z || y <= z && y >= x = y
    | otherwise = z

-- fact 0 = 1
-- fact n = n * fact (n - 1)
factorial :: Int -> Int
factorial 0 = 1
factorial 1 = 1
factorial n = n * factorial (n - 1)

-- Задача 1: Да се реализира функцията max x y z, която връща най-голямото от 3 числа
myMax :: Int -> Int -> Int -> Int
myMax x y z
    | x >= y && x >= z = x
    | y >= z           = y
    | otherwise        = z

-- Задача 2: Да се реализира функцията fib n, която връща n-тото число на Фибоначи
-- fib(0) = 0, fib(1) = 1, fib(n) = fib(n - 1) + fib(n - 2)
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n
    | n < 0     = error "n >= 0"
    | otherwise = fib (n - 1) + fib (n - 2)

-- Задача 3: Да се реализира функция isPalindrome n, която проверява дали n е палиндром
{-
    1234
    => 4321
    4 * 10^3 + 3 * 10^2 + 2 * 10^1 + 1 * 10^0
-}
isPalindrome :: Integer -> Bool
isPalindrome n = n == reverseNumber n (countDigits n - 1)
    where
        reverseNumber num pos
            | num < 10  = num
            | otherwise = (num `mod` 10) * (10 ^ pos) + reverseNumber (num `div` 10) (pos - 1)
        countDigits n
            | n < 10    = 1
            | otherwise = 1 + countDigits (div n 10)


findDivisorsInRange :: Integer -> Integer -> Integer -> Bool
findDivisorsInRange left right num
    | left > right          = False
    | num `mod` left == 0   = True
    | otherwise             = findDivisorsInRange (left + 1) right num

-- Задача 4: Да се реализира функция isPrime n, която проверява дали n е просто число
isPrime :: Integer -> Bool
isPrime n
    | n < 2          = False
    | otherwise      = not (findDivisorsInRange 2 (n - 1) n)
