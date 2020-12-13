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

import Prelude hiding (abs)

abs :: Int -> Int
abs n = if n >= 0 then n else (-n)

apply :: (a -> b) -> a -> b
apply f x = f x

-- (->) е дясно асоциативна, тоест типа на apply можем да го запишем така:
-- apply :: (a -> b) -> (a -> b)
-- id :: a -> a
-- но а е произволен тип, в частност (a -> b)
apply' :: (a -> b) -> a -> b
apply' = id

-- това връща функция защото се прилага частично (x не се подава)
-- т.е. се извиква така и резултата е функция която чака
-- още един аргумент да бъде подаден
-- compose even succ
compose :: (b -> c) -> (a -> b) -> a -> c
compose f g x = f (g x)

-- Помните функциите take и drop
-- В Haskell са вградени
prefix :: [Int] -> [Int] -> Bool
prefix xs ys = take (length xs) ys == xs

suffix :: [Int] -> [Int] -> Bool
suffix xs ys = drop (length ys - length xs) ys == xs

weakListComprehension :: [a] -> (a -> Bool) -> (a -> b) -> [b]
weakListComprehension xs p f = map f (filter p xs)

closed :: [Int] -> (Int -> Int) -> [Int]
closed xs f = filter (\x -> f x `elem` xs) xs
