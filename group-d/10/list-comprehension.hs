{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}
-- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}
-- no incomplete patterns in lambdas!

import Prelude hiding (pi)

-- Една конструцият която не съм ви показал е
-- case <expr> of {<case-match>}+
fib :: Int -> Int
fib n = case n of
          0 -> 1
          1 -> 1
          m -> fib (m - 1) + fib (m - 2)

-- Всъщност pattern matching-а е синтактична захар
-- за разглеждане на случаи


---------------
-- Pointfree --
---------------

-- Няколко полезни оператора/функции

-- flip :: (a -> b) -> b -> a
-- За дадена функция на 2 аргумента връща нова функция,
-- но с обърнат ред на аргументите

-- ($) - апликация, тя е с най-нисък приоритет (тоест ще се изпълни последна)
-- Пример: Искаме да вземем първите n прости числа на квадрат
-- take n (map (^2) (filter prime [2..]))
-- take n $ map (^2) $ filter prime [2..]

-- (.) - композиция
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- Пример: отрицание на предикат
-- complement p = (\x -> not $ p x)
-- complement p x = not $ p x
-- complement p = not . p

-- TODO: pointfree?


------------------------
-- List Comprehension --
------------------------

-- Няколко важни неща за списъци:
-- Списъците в Haskell са потоци
-- т.е. са мързеливи и могат да са безкрайни.

-- Съответно всички стандартни функции върху списъци,
-- работят дори и списъците да са безкрайни.


-- List generators:

-- Генератори на списъци (синтактична захар за enumFrom...)
-- можем да генерираме списъци от последователни елементи (числа, символи и др.)

-- безкраен списък с елементи започващи от n
-- enumFrom n = [n..] = [n,n+1,n+2,...]

-- безкраен списък с елементи започващи от n и всеки следващ със стъпка m-n=k
-- enumFromThen n m = [n,m..] = [n,m,m+k,m+2k,...]

-- Списък от елементите от n до m
-- enumFromTo n m = [n..m] = [n,n+1,...,m-1,m]
-- [10..1] = [] -- не можем да правим списъци с низходящи елементи

-- Списък от елементите от n до най-много k, и стъпка m-n
-- enumFromThenTo n m k = [n,m..k]
-- [1,3..10] = [1,3,5,7,9]
-- [10,9..1] = [10,9,8,7,6,5,4,3,2,1]
-- така вече можем да правим това от горния пример

-- TODO: примери за генератори

-- List comprehension:
-- [<expr> | {<generator>}+, {<condition>}+]

-- generator е от вида <pattern> <- [a]
-- където <pattern> пасва на елемент от тип a

-- крайният резултат е списък от <expr> за всеки елемент получен от <generator>
-- за който са изпълнени всички условия

-- Пример:
-- [(x,y) | x<-[1..10], y<-[1..10], odd x, even y]
-- всички двойки (x,y), такива че
-- x е от [1..10], y е от [1..10], x е нечетно и y е нечетно
-- * всички двойки означава всяко със всяко когато имаме 2 генератора


-----------------------
-- Вложени дефиниции --
-----------------------

-- Една конструкция с която можем да правим вложени дефиниции е let
-- let <definitions> in <body>
-- Пример:
circlePerimeter :: Float -> Float
circlePerimeter r = let pi = 3.14
                    in 2 * pi * r

-- Друга конструкция е where

-- <function-definition>
--    where <def1>
--          <def2>
--           ...
--          <defn>
-- Пример:
circleArea :: Float -> Float
circleArea r = pi * r * r
    where pi = 3.14

-- освен че с where е по-приятно за четене, има и други разлики:
-- let е израз и може да участва във всеки друг израз
-- where може да се ползва само в рамките на дефиниция
-- TODO: Пример


-- ЗАДАЧИ
-- няколко за загрявка

-- за списък от цели числа, премахва дубликатите
nub :: [Int] -> [Int]
nub = undefined

-- quicksort за цели числа
quicksort :: [Int] -> [Int]
quicksort = undefined

-- Проверява дали число е просто
prime :: Int -> Bool
prime = undefined

-- За дадено число n връща списък от първите n прости числа
primes :: Int -> [Int]
primes = undefined

-- За дадено естествено число, връща списък от простите му делители
-- factorize 60 = [2, 2, 3, 5]
factorize :: Int -> [Int]
factorize = undefined
