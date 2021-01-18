{-# LANGUAGE InstanceSigs #-}
-- can write signatures in instance declarations
{-# LANGUAGE KindSignatures #-}
-- can write kind signatures

{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- cover all cases!
{-# OPTIONS_GHC -fwarn-unused-matches #-}
-- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}
-- warn about incomplete patterns v2

import Prelude hiding (Maybe(..), Either(..), Semigroup(..), Monoid(..), Functor(..))


-- Последно се занимавахме с Maybe и BTree
data Maybe a
  = Nothing
  | Just a
  deriving Show

-- Нещо, което би ни се наложило да правим с Maybe
-- би било да поменим стойността му
-- За да не правим разглеждане на случаи всеки път с case,
-- нека си напишем функция и си спестим писане.
mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe _ Nothing = Nothing
mapMaybe f (Just x) = Just $ f x

-- Тази дефиниция ни изглежда позната
-- За списъци изглеждаше така:
-- map :: (a -> b) -> [a] -> [b]

-- За дървета също писахме нещо подобно
data Tree a
  = Empty
  | Node a (Tree a) (Tree a)
  deriving Show
-- mapTree :: (a -> b) -> Tree a -> Tree b
-- Не може ли да генерализираме такива неща?
-- (които могат да се map-ват)

-- Вече се сблъскахме с Eq и Ord,
-- където искахме представителите на даден тип
-- да поддържат дадена операция.
-- В случея обаче е по-различно,
-- Защото (Tree a) е тип който зависи от типа на "a".
-- Точно както стойностите(terms) се класифицират в различни типове(types),
-- така и типовете се класифицират във видове(kinds).

-- TODO: примери :k
-- Представете си че вместо * пише Type
-- TODO: вида на Maybe
-- TODO: типови конструктори (малко като функции)

-- TODO: типа на fmap

-- Това защо ни трябваше да го знаем?
-- Ами можем да дефинираме клас над неща с различен вид от *
class Functor (f :: * -> *) where
  fmap :: (a -> b) -> f a -> f b

-- TODO: map е просто fmap за списъци
-- TODO: инфиксен оператор <$> за fmap

-- Вече можем да си направим Maybe инстанция на Functor
instance Functor Maybe where
  fmap :: (a -> b) -> Maybe a -> Maybe b
  fmap _ Nothing = Nothing
  fmap f (Just x) = Just $ f x


-- Също така писахме прости функции за дървета
-- Като такава, която намира сумата на елементите
-- на дърво от числа.
-- Не може ли да е дърво от произволни елементи?
-- Тогава те трябва да поддържат някаква бинарна операция.
-- Като ползваме fold попринцип ни трябва и някаква начална стойност.
class Monoid a where
  mempty :: a
  (<>) :: a -> a -> a -- mappend
-- Методите на моноида както при други класове,
-- трябва да изпълняват определени свойства:
-- mempty запазва идентитета
-- mempty <> x == x == x <> mempty
-- (<>) е асоциативна
-- (x <> y) <> z == x <> (y <> z)
infixr 6 <>

-- TODO: Пример на mempty и (<>) със списъци
-- TODO: Monoid Int?

-- Int като моноид със събиране
newtype Sum = Sum Int
  deriving Show
-- newtype е като data, но само с 1 конструктор

getSum :: Sum -> Int
getSum (Sum x) = x

instance Monoid Sum where
  mempty :: Sum
  mempty = Sum 0
  (<>) :: Sum -> Sum -> Sum
  (<>) (Sum x) (Sum y) = Sum (x + y)

-- Int като моноид със умножение
newtype Prod = Prod Int
  deriving Show

getProd :: Prod -> Int
getProd (Prod x) = x

instance Monoid Prod where
  mempty :: Prod
  mempty = Prod 1
  (<>) :: Prod -> Prod -> Prod
  (<>) (Prod x) (Prod y) = Prod (x * y)

-- Тук можете да четете за различните типови класове в Haskell
-- https://wiki.haskell.org/Typeclassopedia


------------
-- ЗАДАЧИ --
------------

data Nat
  = Zero
  | Succ Nat
  deriving Show

-- Да си улесним живота с писането на Nats
instance Num Nat where
  fromInteger :: Integer -> Nat
  fromInteger 0 = Zero
  fromInteger n = Succ $ fromInteger $ n - 1
  (+) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  negate = undefined



-- Събиране за Nat
instance Monoid Nat where
  mempty :: Nat
  mempty = undefined
  (<>) :: Nat -> Nat -> Nat
  (<>) = undefined

-- Конкатенация на списъци
instance Monoid [a] where
  mempty :: [a]
  mempty = undefined
  (<>) :: [a] -> [a] -> [a]
  (<>) = undefined

-- fold на дърво от моноиди
-- Вече имаме бинарна операция, с която да комбинираме елементите
foldTree :: Monoid a => Tree a -> a
foldTree = undefined

-- повторение на моноид Nat пъти
-- repeatMonoid (3 :: Nat) (2 :: Nat) == (6 :: Nat)
-- repeatMonoid 3 [1,2,3] == [1,2,3,1,2,3,1,2,3]
repeatMonoid :: Monoid a => Nat -> a -> a
repeatMonoid = undefined

-- конкатенация на списък от моноиди
-- monoidConcat [[1,2,3],[4,5,6],[7,8,9]] == [1,2,3,4,5,6,7,8,9]
-- monoidConcat [(1 :: Nat),2,3] == [<6 as a nat>]
monoidConcat :: Monoid a => [a] -> a
monoidConcat = undefined

-- Първо map и после fold на дърво
foldMapTree :: Monoid m => (a -> m) -> Tree a -> m
foldMapTree = undefined

instance Functor Tree where
  fmap :: (a -> b) -> Tree a -> Tree b
  fmap = undefined

-- А сега с помощта на fmap
foldMapTree' :: Monoid m => (a -> m) -> Tree a -> m
foldMapTree' = undefined

-- Either е друг смислен тип.
-- Мислете си за Maybe, но при провалена операция
-- ще връщаме (Left e) вместо Nothing.
-- Така не губим информация при провал.
-- Или ако искаме да върнем резултат който може да е 1 от 2 неща.
-- Пример: safeDiv 5 0 -- Left "Cannot divide by 0"
data Either e a
  = Left e
  | Right a
  deriving Show

-- Забележете как Either тук е частично прложен типов конструктор
-- Където "e" е фиксирано за дефиницията на Functor
instance Functor (Either e) where
  fmap :: (a -> b) -> Either e a -> Either e b
  fmap = undefined

-- Да приемем че Tree е двоично наредено дърво
-- Имплементирайте bstPath, която за дадено такова дърво и елемент
-- Да намери път до елемента, представен като списък от посоки
-- Just [Direction]
-- Ако няма такъв път функцията да връща Nothing.
data Direction = L | R
  deriving Show

bstPath :: Ord t => Tree t -> t -> Maybe [Direction]
bstPath = undefined
