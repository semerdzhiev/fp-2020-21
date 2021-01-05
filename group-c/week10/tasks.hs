{-
типове:
    *Int, Integer, Float, Double, Bool (True, False)
    *Char ('a'), String("this is a string") (== [Char]), списък

списъци:
    head, tail, : (cons), ++ (append), null, литерали
    вградени функции - elem, take, drop, reverse
    още - map, filter, foldl, foldr, *zipWith
    и още - minimum, maximum, sum, product
    * range (with step)
    * list comprehension!
        - общ вид: [ <израз който искаме да върнем> | <принадлежност и условия за променливите от израза> ]

ламбди!
    - общ вид (\ <списък с аргументи> -> <израз, който да върнем>)
-}

{- Пример 1. факториел -}
factorial :: Integer -> Integer
factorial n = product [1..n]

{- Пример 2. isPalindrome -}
isPalindrome :: Integer -> Bool 
isPalindrome n =
    let
        digits = getDigits n
    in
        digits == reverse digits
    where
        getDigits n
            | n < 10    = [n]
            | otherwise = getDigits (n `div` 10) ++ [n `mod` 10]

-- Задача 1: Да се напише функция times n x, която създава списък
-- от елемента x повторен n пъти
times :: Integer -> a -> [a]
times 0 _ = []
times n x = x : times (n - 1) x

-- Задача 2: Да се напише функция myReverse xs, която връща
-- обърнатия списък на подаден списък xs
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- Задача 3: Да се напише функция getAllRightTriangles n,
-- която връща наредени тройки от всички възможни комбинации на страни (a, b, c)
-- на правоъгълен триъгълник, за които a <= n, b <= n, c <= n, a <= b <= c
getAllRightTriangles :: Integer -> [(Integer , Integer , Integer )]
getAllRightTriangles n = [(a, b, c) | a <- [1..n], b <- [1..n], a < b, c <- [1..n], a^2 + b^2 == c^2]

-- Задача 4: Да се напише функцията myQuickSort xs
myQuickSort :: (Ord a) => [a] -> [a]
myQuickSort [] = []
myQuickSort (x:xs) = smaller ++ [x] ++ bigger
    where
        smaller = myQuickSort [y | y <- xs, y < x]
        bigger = myQuickSort [y | y <- xs, y >= x]

-- Задача 5: Да се напише функция myMergeSort xs
merge :: (Ord a) => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x < y     = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

myMergeSort :: (Ord a) => [a] -> [a]
myMergeSort [] = []
myMergeSort [x] = [x]
myMergeSort xs = merge mergedFirstHalf mergedSecondHalf
    where
        mergedFirstHalf = myMergeSort firstHalf
        mergedSecondHalf = myMergeSort secondHalf
        firstHalf = take half xs
        secondHalf = drop half xs
        half = length xs `div` 2
