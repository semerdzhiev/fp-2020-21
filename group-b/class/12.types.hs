import Prelude hiding (sum)

sum :: [Int] -> Int
sum [] = 0
sum (x:xs) = x + sum xs

-- type String = [Char]

data List a = EmptyList | Cons a (List a) deriving Show
--instance List a Show where
--  show EmptyList = "[]"
--  show (Cons x xs) = ""
-- data StringList = EmptyStringList | ConsStringList String StringList
-- Read

type Name = String
type Age = Int
data Person = Person Name Age | PersonWithId Name Int deriving Eq

p1 :: Person
p1 = Person "Name" 20

p2 :: Person
p2 = PersonWithId "Name" 33

--instance Eq Person where
--  (Person n1 a1) == (Person n2 a2) = n1 == n2 && a1 == a2
--  (Person n1 _) == (PersonWithId n2 _) = n1 == n2
--  _ == _ = False

exampleList :: List Int
exampleList = Cons 1 (Cons 2 (Cons 3 EmptyList))

stringList :: List String
stringList = Cons "string1" (Cons "string2" EmptyList)

exampleEmptyList = EmptyList

sum' :: List Int -> Int
sum' EmptyList = 0
sum' (Cons x xs) = x + sum' xs

-- премахваме първото срещане на даден елемент от списък
-- remove :: Int -> List Int -> List Int

-- индекс на първото срещане на дадено число в списък
-- започваме от 0
--find :: (Ord a) => a -> List a -> Maybe Int
--find _ EmptyList = Nothing 
--find e (Cons x xs)
--  |e == x = Just 0
--  |otherwise = Just 1 + find e xs

--indexToString :: (Ord a) => a -> List a -> Maybe String
--indexToString e lst = case (find e lst) of
--  Nothing -> Nothing
--  (Just x) -> Just (show x)




-- искаме да вкараме елемент x точно преди елемент от списъка xs, който е по-голям от него
-- insert 1 [] -> [1]
-- insert 3 [1,2] -> [1,2,3]
--
insert :: (Ord a) => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)
  |x < y = x:y:ys
  |otherwise = y : insert x ys

-- Enum - [1..20], ['c'..'z']

-- f :: (Ord a, Eq b) => a -> b -> a

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = (f x) : map' f xs

applyToMaybe :: (a -> b) -> Maybe a -> Maybe b
applyToMaybe _ Nothing = Nothing
applyToMaybe f (Just x) = Just (f x)

addOne :: Int -> Int
addOne = (plus 1)

plus :: Int -> (Int -> Int)
plus a b = a + b

a = (plus 2) 3

-- data Maybe a = Nothing | Just a 






