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
{-# LANGUAGE InstanceSigs #-}
-- allows us to write signatures in instance declarations


-----------------
-- TYPECLASSES --
-----------------

-- Нека разгледаме първо някой полиморфични функции над списъци
-- reverse :: [a] -> [a]
-- length :: [a] -> [a]
-- head :: [a] -> a
-- Тези функции могат да работят с елементи от произволен тип
-- Още повече те не се интересуват от самите елементи
-- (a е типова променлива)
-- Това се нарича параметричен полиморфизъм
-- ([] е полиморфна константа)

-- Ето една имплементация на quicksort за числа
-- Какво обаче ако искаме да работи и за елементи от други типове
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (x:xs) = quicksort lower ++ [x] ++ quicksort higher
  where lower = [y | y<-xs, y <= x]
        higher = [y | y<-xs, y > x]

-- Нека погледнем следната декларация на quicksort
-- quicksort :: Ord a => [a] -> [a]

-- "Ord a" казва че тези елементи от типа a
-- трябва да можем да ги сравняваме
-- Нарича се class constraint (класово ограничение)
-- Това е различен тип полиморфизъм (ad-hoc),
-- той изисква някакви допълнителни свойства от елементите

-- Ord е типов клас, НЕ клас като тези в ООП

-- Може да си мислите за типовите калсове
-- като множества/предикати/интерфейси

-- Списъка е полиморфна константа
-- Числата са полиморфни константи

-- Инстанция на типов клас наричаме всеки тип,
-- за който са реализирани операциите зададени в класа.
-- Тези операции наричаме методи на съответния клас.
-- Нека видим как можем да направим някой тип, инстанция на някой клас.

data Parity
  = Even
  | Odd
  deriving Show

-- Show е типов клас, чйито инстанции могат да бъдат
-- извеждани на екрана и конвертирани към String

-- deriving казва на Haskell да се опита да генерира нужните функции,
-- за да бъде типа инстанция на изброените класове


-- Нека разгледаме няколко основни класа - Num, Eq, Ord
-- И ще видим как да направим Parity тяхна инстанция

-- Num
-- За да можем да кастваме числа към Parity
-- е достатъчно да сме имплементирали fromIntegral
-- Пример:
-- 5 :: Parity -- Odd
instance Num Parity where
  -- попринцип не можем да пишем декларации тук,
  -- но съм сложил флаг горе
  fromInteger :: Integer -> Parity
  fromInteger n = case n `mod` 2 of
                    0 -> Even
                    _ -> Odd
  (+) = undefined -- събиране
  (*) = undefined -- изваждане
  abs = undefined -- абсолютна стойност (модул)
  signum = undefined -- знак +1/0/-1
  negate = undefined -- обръща знака


-- Eq
-- Достатъчно е да се имплементира поне едно от: (==), (/=)
-- Защото могат да се имплементират взаимно
instance Eq Parity where
  (==) :: Parity -> Parity -> Bool
  Odd  == Odd  = True
  Even == Even = True
  _    == _    = False
  (/=) :: Parity -> Parity -> Bool
  Even /= Odd  = True
  Odd  /= Even = True
  _    /= _    = False

-- Закони за Eq (еквивалентност):
-- За всяко x y z
-- x == x
-- x == y -> y == x
-- x == y && y == z -> x == z


-- Ord
-- Достатъчно е да се имплементира едно от: compare, (<=)
-- Защото могат да се имплементират взаимно
-- compare връща Ordering, а то има следната дефиниция:
-- data Ordering = LT | EQ | GT

-- Можем да ги имплементираме с идеята че,
-- Even е като 0
-- Odd е като 1
-- Заради остатъците при делене на 2
instance Ord Parity where
  compare :: Parity -> Parity -> Ordering
  compare Odd Even = LT
  compare Even Odd = GT
  compare _ _ = EQ
  (<=) :: Parity -> Parity -> Bool
  Odd <= Even = False
  _ <= _ = True

-- Закони за Ord (частична наредба):
-- За всяко x y z
-- x <= x
-- x <= y && y <= x -> x == y
-- x <= y && y <= z -> x <= z


------------
-- ЗАДАЧИ --
------------

data Nat
  = Zero
  | Succ Nat
  deriving Show

-- Имплементирайте нужните функции за да бъде
-- Nat инстанция на класовете Num, Eq, Ord

instance Num Nat where
  fromInteger :: Integer -> Nat
  fromInteger = undefined
-- Няма нужда да имплементирате долните
  (+) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  negate = undefined

-- Изберете един да реализирате.
-- Другият имплементирайте чрез избрания.
instance Eq Nat where
  (==) :: Nat -> Nat -> Bool
  (==) = undefined
  (/=) :: Nat -> Nat -> Bool
  (/=) = undefined

-- Изберете един да реализирате.
-- Другият имплементирайте чрез избрания.
instance Ord Nat where
  compare :: Nat -> Nat -> Ordering
  compare = undefined
  (<=) :: Nat -> Nat -> Bool
  (<=) = undefined

-- Имплементирайте mergeSort
mergeSort :: Ord a => [a] -> [a]
mergeSort = undefined
