
{-
partial function application:
    - израз: 2 + 3
    - функция (2+)

application & composition:
    - application ($): отляво стои функция, а отдясно - аргумент;
        "приложи аргумента отдясно на функцията отляво"
    - composition (.): математическа композиция на функции;
        "създай нова функция, равна на f(g(x)) за всяко x"

напомняне за полезни функции:
    - map, filter, fold, zip, zipWith
    - any, all, elem
    - toUpper, toLower, isUpper, isLower, isSpace
    - take(While), drop(While)
    - generators
-}

-- Задача 1: Напишете функция countMinimum, която връща броя
-- срещания на минималния елемент от списък в списъка
countMinimum :: (Ord a) => [a] -> Int 
countMinimum xs = undefined

-- Задача 2: Напишете функция isPrime, която по подадено число
-- връща дали числото е просто
isPrime :: Integer -> Bool 
isPrime x = undefined

-- Задача 3: Напишете функция filterPrimePositions, която
-- връща елементите на списък само ако позициите им са прости числа
filterPrimePositions :: [a] -> [a]
filterPrimePositions xs = undefined

-- Задача 4: Напишете функция split, която по даден списък xs
-- и разделител s връща списък от списъци, съставени от елементите
-- между разделителите
split :: (Eq a) => [a] -> a -> [[a]]
split xs s = undefined

-- Задача 4: Напишете функция split, която по даден списък от списъци xss
-- и съединител s връща списък съставен от съединените списъци
-- с елемента s помежду им
join :: [[a]] -> a -> [a]
join xss s = undefined

-- Задача 5: Напишете функция repeat f n, която представлява f^n(x)
repeat :: (a -> a) -> Integer -> (a -> a)
repeat f n = undefined

-- Задача 6: Напишете функция title, която по подаден низ връща
-- низа във формат на заглавие (първите букви на всяка дума са главни,
-- а останалите - малки)
title :: String -> String
title s = undefined

-- Задача 7: Напишете функция isPangram, която по подаден низ
-- проверява дали съдържа всички букви от английската азбука
isPangram :: String -> Bool
isPangram s = undefined

-- Задача 8*: Дефинирайте тип данни, изобразяващ претеглен граф, и напишете
-- функция shortestPath, която по подаден граф и начален и краен връх
-- намира най-късият път между тях
data Graph nodeT weightT = Empty

shortestPath :: (Num w) => Graph n w -> n -> n -> w
shortestPath graph start finish = undefined