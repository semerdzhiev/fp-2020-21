{-
Debugging in Haskell

типове:
    *Int, Integer, Float, Double, Bool (True, False)
    *Char ('a'), String("this is a string") (== [Char]), списък

списъци:
    head, tail, : (cons), ++ (append), null, литерали
    вградени функции - map, filter, foldl, foldr, *zipWith
    още - elem, take, drop, reverse
    и още - minimum, maximum, sum, product
    * range (with step)
    * list comprehension!

ламбди!
-}

{- Пример 1. факториел -}
factorial :: Integer -> Integer
factorial n = undefined

{- Пример 2. isPalindrome -}
isPalindrome :: Integer -> Bool 
isPalindrome n = undefined 

-- Задача 1: Да се напише функция times n x, която създава списък
-- от елемента x повторен n пъти
times :: Integer -> a -> [a]
times n x = undefined 

-- Задача 2: Да се напише функция myReverse xs, която връща
-- обърнатия списък на подаден списък xs
myReverse :: [a] -> [a]
myReverse xs = undefined 

-- Задача 3: Да се напише функция getAllRightTriangles n,
-- която връща наредени тройки от всички възможни комбинации на страни (a, b, c)
-- на правоъгълен триъгълник, за които a <= n, b <= n, c <= n, a <= b <= c
getAllRightTriangles :: Integer -> [(Integer , Integer , Integer )]
getAllRightTriangles n = undefined 

-- Задача 4: Да се напише функцията myQuickSort xs
myQuickSort :: (Ord a) => [a] -> [a]
myQuickSort xs = undefined

-- Задача 4: Да се напише функция myMergeSort xs
myMergeSort :: (Ord a) => [a] -> [a]
myMergeSort xs = undefined