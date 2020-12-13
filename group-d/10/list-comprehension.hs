{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}      -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}           -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}       -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}           -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}  -- no incomplete patterns in lambdas!

import Prelude hiding (pi)

-- Няколко неща на кратко
-- TODO: basic list functions + null
-- Списъците в Haskell са потоци (TODO: Примери)

-- TODO: List generators
-- Генератори на списъци (синтактична захар за enumFrom...)
-- можем да генерираме списъци от последователни елементи (числа, символи и др.)

-- безкраен списък с елементи започващи от n
-- [n..] - n, n+1, n+2, ...
-- enumFrom n
-- TODO: Примери

-- безкраен списък с елементи започващи от n и всеки следващ със стъпка m-n
-- [n,m..]
-- enumFromThen n m
-- TODO: Примери

-- Списък от елементите от n до m
-- [n..m]
-- enumFromTo n m
-- TODO: Примери

-- Списък от елементите от n до най-много k, и стъпка m-n
-- [n,m..k]
-- enumFromThenTo n m k
-- TODO: Примери

-- List comprehension

-- [<expr> | {<generator>}+, {<condition>}+]

-- generator е от вида <pattern> <- [a]
-- където <pattern> пасва на елемент от тип a

-- крайният резултат е списък от <expr> за всеки елемент получен от <generator>
-- за който са изпълнени всички условия

-- Пример:
-- [ (x,y) | x <- [1..10], y <- [1..10], odd x, even y ]
-- всички двойки (x,y), такива че
-- x е от [1..10], y е от [1..10], x е нечетно и y е нечетно
-- * всички двойки означава всяко със всяко когато имаме 2 генератора


-- Вложени дефиниции

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
