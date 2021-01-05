{-
Типове
    - общ вид на дефиниция на типове:
    data <име на тип> = <конструктор> ( | <конструктор> )*
-}

-- Пример: списък от елементи от тип "а"
data List a = Nil | Cons { myListHead :: a, myListTail :: List a }
    deriving Show

-- myLength :: [a] -> Int
-- myLength [] = 0
-- myLength (_:xs) = 1 + myLength xs

myListLength :: List a -> Int
myListLength Nil = 0
myListLength (Cons _ xs) = 1 + myListLength xs

{-
Именувани getter-и: при дефиниране на тип можем да създадем функции,
с които да достъпваме съответните данни на дадения тип
-}

-- Пример: представяне на двоично дърво
data Tree a = Empty | Node { nodeData :: a, left :: Tree a, right :: Tree a }
    deriving Show

treeDepth :: Tree a -> Int
treeDepth Empty = 0
treeDepth (Node _ l r) = 1 + max (treeDepth l) (treeDepth r)

-- Задача 0: Да се напише функция countLeaves, която
-- връща броя на листата в дадено дърво
countLeaves :: Tree a -> Int
countLeaves Empty = 0
countLeaves (Node _ Empty Empty) = 1
countLeaves (Node _ l r) = countLeaves l + countLeaves r

-- Задача 1: Да се напише функция toList, която
-- връщя елементите на дадено дърво в списък,
-- като обходи дървото в посока ляво-корен-дясно 
toList :: Tree a -> [a]
toList Empty = []
toList (Node x l r) = leftSubtreeList ++ x:rightSubtreeList
    where
        leftSubtreeList = toList l
        rightSubtreeList = toList r

-- Задача 2: Да се напише функция isMirror t1 t2, която
-- проверява дали дървото t1 и дървото t2 са огледални едно на друго
isMirror :: (Eq a) => Tree a -> Tree a -> Bool
isMirror Empty Empty = True
isMirror (Node x xl xr) (Node y yl yr) = x == y && isMirror xl yr && isMirror xr yl
isMirror _ _ = False

-- Задача 3: Да се напише функция binarySearch tree elem,
-- която по подадено двоично дърво за търсене tree
-- намира дали елемента elem се съдържа в него
binarySearch :: (Ord a, Eq a) => Tree a -> a -> Bool
binarySearch Empty _ = False
binarySearch (Node x xl xr) elem
    | elem == x = True
    | elem < x  = binarySearch xl elem
    | otherwise = binarySearch xr elem

-- Задача 4: Да се напише функция binaryInsert tree elem,
-- която добавя елемента elem към двоичното дърво за търсене tree 
binaryInsert :: (Ord a, Eq a) => Tree a -> a -> Tree a
binaryInsert Empty x = Node x Empty Empty
binaryInsert (Node x xl xr) elem
    | elem == x = Node x xl xr
    | elem < x  = Node x (binaryInsert xl elem) xr
    | otherwise = Node x xl (binaryInsert xr elem)

bstFromList :: (Ord a, Eq a) => [a] -> Tree a
bstFromList xs = foldl binaryInsert Empty xs

-- Задача 5: Да се напише функция binaryRemove tree elem,
-- която премахва елемента elem към двоичното дърво за търсене tree.
-- Ако елементът не е в дървото, да се върне изходното дърво
binaryRemove :: (Ord a, Eq a) => Tree a -> a -> Tree a
binaryRemove tree elem = undefined
