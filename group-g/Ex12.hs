module Ex12 (specialSort, IntTree(..), treeSum) where

import Data.List (nub,sortOn,maximumBy)
import Data.Ord (comparing)

-- Eq - за типовете, чиито стойности могат да бъдат сравнявани с == или /=
-- Ord - за типовете, чиито стойности могат да бъдат сравнявани с </<=/>/>=
-- Show, Read
-- Integral - множеството целочислен типове (Int, Integer, Char, ...)
-- Floating - множеството дробни числа (Float,Double)
-- Num - за всички числа

mostFrequent :: (Eq a) => [a] -> a
mostFrequent xs = fst $ maximumBy (comparing snd) histo
  where --histo :: [(a,Int)]
        histo = histogram xs

histogram :: Eq a => [a] -> [(a,Int)]
histogram xs = [(x, count x xs) | x<-uniques xs ]
  where count x xs = length $ filter (==x) xs

uniques :: Eq a => [a] -> [a]
uniques = nub -- всъщност я има вградена

specialSort :: (Eq a, Ord a) => [[a]] -> [[a]]
specialSort xss = sortOn mostFrequent xss

-- Нов тип данни, т.нар. strong enum
data Parity = Even | Odd

-- Ако автоматично инстанциране с deriving не върши работа
-- (в случая върши, тук е за пример)
instance Eq Parity where
  Even == Even = True
  Odd == Odd = True
  _ == _ = False

parity :: Int -> Parity
parity x = if even x then Even else Odd

isEven :: Parity -> String
isEven Even = "iei"
isEven _ = "noooo"

-- Хубав пример как да pattern-match-ваме стойност,
-- произлязла от междинна сметка, а не само подаден аргумент.
isEven' :: Int -> String
isEven' x = case parity x of Even -> "neshto si"
                             _ -> "neshto drugo"

-- Аналогична, но значително по-неудобна конструкция
--isEven' x = helper (parity x)
--  where helper Even = "neshto si"
--        helper _ = "neshto drugo"

-- Конструкторите могат да приемат и друг вид аргументи
-- (вкл. от същия тип) - така се получават т.нар. алгебричен тип.
-- Представлява алтернатива между "подтиповете",
-- дефинирани от отделните конструктори.
data IntTree = Empty
             | Node Int IntTree IntTree

-- Вместо getter функции можем с pattern matching едновременно да
-- разпознаваме алтернативите, и да даваме имена на мембърите :)
-- Останалата идея за решението е позната.
treeSum :: IntTree -> Int
treeSum Empty = 0
treeSum (Node val left right) = val + treeSum left + treeSum right
