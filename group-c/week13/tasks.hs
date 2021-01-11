import Prelude hiding (Maybe, maybe)

data Maybe a = Nothing | Just a deriving Show

-- Да се напише функция safeDiv, която по подадени цели числа x и y
-- връща частното им ако може да се дели на y
safeDiv :: Int -> Int -> Maybe Int
safeDiv x y = undefined

-- Да се напише функция safeHead, която по подаден списък от елементи xs
-- връща първия елемент от списъка ако е непразен
safeHead :: [a] -> Maybe a
safeHead xs = undefined

-- Да се напише функция foldFirst, която прилага foldr върху опашката
-- списъка xs с първоначална стойност главата на списъка xs ако той е непразен
foldrFirst :: [a] -> (a -> a -> a) -> Maybe a
foldrFirst xs f = undefined

-- Дефиниция на двоично дърво
data BinTree a = Empty | Node a (BinTree a) (BinTree a)

-- Да се напише функция mapTree, която по подадено двоично дърво t
-- и едноместна функция f връща ново дърво, получено от прилагането
-- на f върху данните във върховете на t
mapTree :: BinTree a -> (a -> a) -> BinTree a
mapTree t f = undefined

-- Да се напише функция anyTree, която по подадено двоично дърво t
-- и предикат p проверява дали p е изпълнен за някои елементи на t
anyTree :: BinTree a -> (a -> Bool) -> Bool
anyTree t p = undefined

-- Да се напише функция allTree, която по подадено двоично дърво t
-- и предикат p проверява дали p е изпълнен за всички елементи на t
allTree :: BinTree a -> (a -> Bool) -> Bool
allTree t f = undefined

-- Да се напише функция anyTree, която по подадено двоично дърво t
-- и стойност x връща поддървото с корен x ако има такова
findSubtreeByRoot :: (Eq a) => BinTree a -> a -> Maybe (BinTree a)
findSubtreeByRoot t x = undefined

-- Да се напише функция isOrdered, която по подадено двоично дърво t
-- проверява дали t е наредено двоично дърво.
-- За имплементацията да се използва типа Maybe a
isOrdered :: (Ord a) => BinTree a -> Bool
isOrdered t = undefined
