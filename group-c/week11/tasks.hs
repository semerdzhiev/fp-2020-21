{-
Типове
    - общ вид на дефиниция на типове: data <име на тип> = <конструктор> ( | <конструктор> )*
-}

-- Пример: списък от елементи от тип "а"
data List a = Nil | Cons a (List a)
    deriving Show

myListLength :: List a -> Int
myListLength _ = undefined

{-
Именувани getter-и: при дефиниране на тип можем да създадем функции, с които да достъпваме съответните данни на дадения тип
-}

-- Пример: представяне на двоично дърво
data Tree a = Empty | Node { nodeData :: a, left :: Tree a, right :: Tree a }
    deriving Show

treeDepth :: Tree a -> Int
treeDepth _ = undefined

-- Задача 0: Да се напише функция countLeaves, която
-- връща броя на листата в дадено дърво
countLeaves :: Tree a -> Int
countLeaves tree = undefined

-- Задача 1: Да се напише функция toList, която
-- връщя елементите на дадено дърво в списък,
-- като обходи дървото в посока ляво-корен-дясно 
toList :: Tree a -> [a]
toList tree = undefined

-- Задача 2: Да се напише функция isMirror t1 t2, която
-- проверява дали дървото t1 и дървото t2 са огледални едно на друго
isMirror :: Tree a -> Tree a -> Int
isMirror t1 t2 = undefined

-- Задача 3: Да се напише функция binarySearch tree elem,
-- която по подадено двоично дърво за търсене tree
-- намира дали елемента elem се съдържа в него
binarySearch :: (Ord a, Eq a) => Tree a -> a -> Bool
binarySearch tree elem = undefined

-- Задача 4: Да се напише функция binaryInsert tree elem,
-- която добавя елемента elem към двоичното дърво за търсене tree 
binaryInsert :: (Ord a, Eq a) => Tree a -> a -> Tree a
binaryInsert tree elem = undefined

-- Задача 5: Да се напише функция binaryRemove tree elem,
-- която премахва елемента elem към двоичното дърво за търсене tree 
binaryRemove :: (Ord a, Eq a) => Tree a -> a -> Tree a
binaryRemove tree elem = undefined