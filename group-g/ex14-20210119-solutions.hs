{-# LANGUAGE InstanceSigs #-} -- позволява да пишем сигнатурите на
-- функциите от инстанцираните класове с цел улеснено разбиране :)

data Bit = Zero | One

data BitVector
  = End
  | BitVector :. Bit

-- Конструкторите могат да са и оператори, т.е. инфиксни, с определени от нас асоциативност и приоритет
infixl 6 :.

instance Show BitVector where
  show :: BitVector -> String
  show = undefined

instance Num BitVector where
  fromInteger :: Integer -> BitVector
  fromInteger = undefined
  (+) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  negate = undefined

-- Изберете един да реализирате.
-- Другият имплементирайте чрез избрания.
instance Eq BitVector where
  (==) :: BitVector -> BitVector -> Bool
  (==) = undefined
  (/=) :: BitVector -> BitVector -> Bool
  (/=) = undefined

-- Изберете един да реализирате.
-- Другият имплементирайте чрез избрания.
instance Ord BitVector where
  compare :: BitVector -> BitVector -> Ordering
  compare = undefined
  (<=) :: BitVector -> BitVector -> Bool
  (<=) = undefined