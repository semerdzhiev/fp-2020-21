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


-- Кортежи (Tuples)
-- До колкото помним наредена n-торка има следния вид в Haskell
-- (e1, .., en)
-- Като елементите могат да са от произволен тип за разлика от списъците
-- всеки кортеж си има конструктор
-- (,) :: a -> b -> (a, b)
-- (,,) :: a -> b -> c -> (a, b, c) и т.н.
-- Няма кортеж от 1 елемент
-- но има празен кортеж - ()

-- С функциите fst и snd можем да вземем съответно първия или втория елемент
-- от наредена двойка (само за двойки)

-- Ако искаме обаче да си дефинираме такива функции за наредени 3-ки??
-- Можем с pattern matching
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- Използвайки кортжи можем да си мислим за тях като обекти с полета
-- Например ако имаме кортежа (Double, Double) може да си мислим за него като
-- точка в двумерното пространство или като (фн, оценка) и т.н.
-- Затова може да му дадем име (или да си създадем тип)

type Vector2 = (Double, Double)

-- Тук със същия успех можем да заместим всеки Vector2 с (Double, Double)
-- и няма да прави разлика
addVectors :: Vector2 -> Vector2 -> Vector2
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)


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

--nub
-- за списък от числа, премахва дубликатите
nub :: (Eq a) => [a] -> [a]
nub = undefined

-- quicksort
quicksort :: (Ord a) => [a] -> [a]
quicksort = undefined

-- Проверява дали число е просто
prime :: Int -> Bool
prime = undefined

-- primes
-- За дадено число n връща списък от първите n прости числа
primes :: Int -> [Int]
primes = undefined

-- Може да решавате задачите за подготовка за контролната
-- В папката в github на Информатика 2 има качени
-- Тези които се предполага че ще можете да решите само на Scheme са
-- тези за структури от данни (дървета, графи)
-- Опитайте се да решите останалите на Haskell (за потоци вие си решавате)

