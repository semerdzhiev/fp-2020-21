{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}      -- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}           -- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}       -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}           -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}  -- no incomplete patterns in lambdas!

import Prelude hiding (map, reverse, filter, foldl, zip, zipWith, takeWhile)


data Nat -- от Natural number (естествено число)
  = Zero
  | Succ Nat
  deriving Show

-- За дадено n връща n - 1
-- predNat от 0 е 0
predNat :: Nat -> Nat
predNat Zero = Zero
predNat (Succ n) = n

-- Превръщане на Integer в Nat
integerToNat :: Integer -> Nat
integerToNat 0 = Zero
integerToNat n = Succ (integerToNat (n - 1))

-- Превръщане на Nat в Integer
natToInteger :: Nat -> Integer
natToInteger Zero = 0
natToInteger (Succ n) = 1 + natToInteger n

-- Събиране
plus :: Nat -> Nat -> Nat
plus Zero m = m
plus (Succ n) m = Succ (plus n m)

-- Умножение
mult :: Nat -> Nat -> Nat
mult Zero _ = Zero
mult (Succ n) m = plus m (mult n m)

-- Имплементирайте някой познати функции за списъци (стандартните списъци в Prelude)

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : (map f xs)

-- типовете на елементите на списъка и акумулатора са различни
-- както ако в Scheme правите foldl върху списък от числа,
-- но с предикат и логическа връзка (and, or) натрупвате булева стойност
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _ acc [] = acc
foldl f acc (x:xs) = foldl f (f acc x) xs

-- Hint: операция за конкатенация на списъци: ++
reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = (reverse xs) ++ [x]

-- Има една функция наречена flip, която разменя аргументите на дадена функция
-- flip :: (a -> b -> c) -> b -> a -> c
-- Можем да напишем reverse по-изчистено и да работи за линейно време
reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []

filter :: (a -> Bool) -> [a]-> [a]
filter _ [] = []
filter p (x:xs) = if p x
                  then x : (filter p xs)
                  else filter p xs

-- За дадени два списъка връща списък от двойки на съответните елементи от списъка.
zip :: [a] -> [b] -> [(a,b)]
zip [] _ = []
zip _ [] = []
zip (x:xs) (y:ys) = (x,y) : (zip xs ys)

-- Прилага поелементно функцията върху двата списъка едновременно.
-- Връща списък от резултатите
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] _ = []
zipWith _ _ [] = []
zipWith f (x:xs) (y:ys) = f x y : (zipWith f xs ys)

-- Връща най-големия префикс на списък,
-- такъв че даденият предикат е изпълнен за всичките му елементи
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile _ [] = []
takeWhile p (x:xs) = if p x then x : takeWhile p xs else []
