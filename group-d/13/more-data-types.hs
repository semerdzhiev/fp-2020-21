{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- cover all cases
{-# OPTIONS_GHC -fwarn-unused-matches #-}
-- use all your pattern matches
{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- write all toplevel signatures
{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- use different names
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}
-- no incomplete patterns in lambdas

import Prelude hiding (Maybe(..), maybe, Either(..), either, lookup)

-- Друго нещо което показах беше type,
-- за да правите псевдоними на типове (type synonyms).
type Student = (String, String, Int)
-- (име, специалност, фн)
-- Тези 3 неща може да ги интерпретираме както си искаме.

-- Също така всеки път като искаме да използваме определено поле
-- трябва да си направим функции които изглеждат така:
getName :: Student -> String
getName (x,_,_) = x
-- А типа може да има и 15 полета ...

-- В този случай можем да си улесним живота
-- като дефинираме свой тип с data и използваме record syntax

data Student'
  = Student { name :: String
            , course :: String
            , facultyNumber :: Int }
  deriving Show
-- Това направи няколко неща които не промениха как се държи програмата ни
-- 0) Генерира функции с имената на полетата,
--  с които можем да взимаме съответните полета
-- 1) Наследения клас Show принтира Student' по различен начин
-- TODO пример

-- Ето един тип, който може да е доста полезен,
-- Maybe, със следната дефиниция:
data Maybe a
  = Nothing
  | Just a
  deriving Show
-- Maybe е малко като конструктивно доказателство
-- т.е. ако Bool твърди дали нещо съществува или не,
-- то Maybe връща нещото ако то съществува

-- основно приложение на Maybe е да се използва за операции,
-- които могат да за провалят (а ние не харесваме exception-и)
-- Пример:
-- head []  -- Грешка
-- safeHead []  -- Nothing
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x


------------
-- ЗАДАЧИ --
------------

-- Двоично дърво с елементи от тип a
data BTree a
  = Empty
  | Node a (BTree a) (BTree a)
  deriving Show

-- При делене на 0 операцията е неуспешна.
-- В противен случай искаме да върнем двойка от коефицент и остатък
safeDiv :: Int -> Int -> Maybe (Int, Int)
safeDiv = undefined

-- Търсим стойност по ключ в асоциативен списък.
-- Може да не намерим такава.
-- Примери:
-- lookup 5 [(10, 'a'), (5,'c')] == Just 'c'
-- lookup 13 [(10, 'a'), (5,'c')] == Nothing
lookup :: Eq k => k -> [(k, v)] -> Maybe v
lookup = undefined

-- Да се вмъкне елемент в дърво, спрямо наредбата на елементите му.
-- Примери:
-- insertOrdered 5 Empty == Node 5 Empty Empty
-- insertOrdered 5 (Node 10 Empty Empty) == Node 10 (Node 5 Empty Empty) Empty
-- insertOrdered 5 (Node 3 Empty Empty) == Node 3 Empty (Node 5 Empty Empty)
insertOrdered :: Ord a => a -> BTree a -> BTree a
insertOrdered = undefined

-- Да се построи binary search tree от списък (използвайте insertOrdered) с елементи от тип a
-- Примери:
-- listToTree [1..10] == Node 10 (Node 9 (Node 8 (Node 7 (Node 6 (Node 5 (Node 4 (Node 3 (Node 2 (Node 1 Empty Empty) Empty) Empty) Empty) Empty) Empty) Empty) Empty) Empty) Empty
-- listToTree [1,10,2,9,3,8] == Node 8 (Node 3 (Node 2 (Node 1 Empty Empty) Empty) Empty) (Node 9 Empty (Node 10 Empty Empty))
listToTree :: Ord a => [a] -> BTree a
listToTree = undefined

-- По дадено дърво от числа да се намери сбора на елементите му.
sumTree :: Num a => BTree a -> a
sumTree = undefined

-- Дали за всеки елемент в дърво е изпълнен даден предикат.
--(Node 5 (Node 2 Empty Empty) (Node 7 Empty Empty))
allTree :: (a -> Bool) -> BTree a -> Bool
allTree = undefined

-- Да се получи списък от обхождането на двоично дърво.
-- Нека обхождането да е ляво-корен-дясно
treeToList :: BTree a -> [a]
treeToList = undefined

-- Проверка дали елемент участва в дадено дърво.
-- elemTree 5 (listToTree [1..10]) == True
-- elemTree 42 (listToTree [1..10]) == False
elemTree :: Eq a => a -> BTree a -> Bool
elemTree = undefined

-- Проверка за съществуване на елемент, изпълняващ даден предикат.
-- findPred even (listToTree [1..10]) -- Just 2
-- findPred (>20) (listToTree [1..10]) -- Nothing
findPred :: (a -> Bool) -> BTree a -> Maybe a
findPred = undefined

-- За дадено двоично дърво от числа, намира максималната сума от числата
-- по някой път от корена до листо
maxSumPath :: (Num a, Ord a) => BTree a -> a
maxSumPath = undefined

-- Реализирайте функция, която за дадено балансирано двоично дърво
-- връща списък от низове, представляващи нивата на дървото
-- Пример:
bt :: BTree Int
bt = Node 0 (Node 1 (Node 3 (Node 7 Empty Empty)
                        Empty)
                    (Node 4 (Node 8 Empty Empty)
                        Empty))
            (Node 2 (Node 5 (Node 9 Empty Empty)
                            (Node 10 Empty Empty))
                    (Node 6 Empty
                            (Node 11 Empty Empty)))
-- printBT bt
-- [“_____0________”,“__1_______2___”,“_3__4__5___6__”,“7__8__9_10__11”]

-- Или ако всеки елемент беше на нов ред:
-- [“_____0________”
-- ,“__1_______2___”
-- ,“_3__4__5___6__”
-- ,“7__8__9_10__11”]

-- Имайте предвид че броя на "_" зависи от броя на символите,
-- нужни за да се принтират елементите от по-високите нива на дървото

-- може да използвате следното:
-- mapM_ putStrLn $ printBT bt
-- за да си принтирате елементите на нови редове
printBT :: (Show a) => BTree a -> [String]
printBT = undefined
