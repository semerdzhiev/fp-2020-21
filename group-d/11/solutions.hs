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


----------------
-- BITVECTORS --
----------------

-- | Let's have bits
-- The same as Bools, but we will use them in a different context.
data Bit = Zero | One
  deriving Show

-- A binary number is a list of bits.
-- We will call this a BitVector.
data BitVector
  = End -- The empty bit vector, i.e. 0
  | BitVector :. Bit
  deriving Show

isEnd :: BitVector -> Bool
isEnd End = True
isEnd (_ :. _) = False

shiftRight :: BitVector -> BitVector
shiftRight End = End
shiftRight (bv :. _) = bv

infixl 6 :.
-- Not important for you right now, but
-- this says that the :. operator associates to the left
-- so End :. One :. Zero
-- actually means
-- (End :. One) :. Zero
-- as opposed to
-- End :. (One :. Zero)
-- which is not well typed,
-- because the (:.) constructor expects
-- a BitVector on the left
-- and a Bit on the right


-- EXAMPLES:

-- Number: 0
-- Binary: 0
-- BitVector: End
--
-- Note that the representation isn't unique, so
-- End :. Zero :. Zero :. Zero
-- is also a valid represntation of 0.
--
-- Number: 6
-- Binary: 110
-- BitVector: End :. One :. One :. Zero
--
-- Number: 5
-- Binary: 101
-- BitVector: End :. One :. Zero :. One

-- Don't forget that
-- End :. One :. Zero :. One
-- is actually
-- ((End :. One) :. Zero) :. One
-- So when you're doing recursion on a BitVector, you have the most "outer" Bit
-- in your pattern match
-- ((End :. One) :. Zero) :. One <-this one

----------------
-- EXCERSISES --
----------------

-- Add one to a BitVector.
-- EXAMPLES:
-- succBitVector End -- End :. One
-- succBitVector (End :. Zero) -- End :. One
-- succBitVector (End :. One :. One :. One)
-- -> End :. One :. Zero :. Zero :. Zero
succBitVector :: BitVector -> BitVector
succBitVector End = End :. One
succBitVector (bv :. Zero) = bv :. One
succBitVector (bv :. One) = (succBitVector bv) :. Zero

-- Detect if a bitvector is zero
-- This is actually helpful for the next task
-- EXAMPLES:
-- isZero End -- True
-- isZero (End :. Zero :. Zero) -- True
-- isZero (End :. One :. Zero) -- False
-- isZero (End :. One) -- False
isZero :: BitVector -> Bool
isZero End = True
isZero (bv :. Zero) = isZero bv
isZero (_ :. One) = False

-- A BitVector is said to be "canonical" if it has no leading zeroes.
-- Write a function to convert a BitVector to it's canonical form.
-- EXAMPLES:
-- canonicalise End -- End
-- canonicalise (End :. One :. Zero) -- End :. One :. Zero
-- canonicalise (End :. Zero :. Zero :. One :. Zero) -- End :. One :. Zero
canonicalise :: BitVector -> BitVector
canonicalise End = End
canonicalise (bv :. bit)
  | isZero bv = End :. bit
  | otherwise = canonicalise bv :. bit
-- HINT:
-- Use isZero

-- Convert a number to a BitVector
-- Ideally convert numbers to canonical bitvectors.
-- EXAMPLES:
-- integerToBitVector 0 -- End
-- integerToBitVector 69
-- -> End :. One :. Zero :. Zero :. Zero :. One :. Zero :. One
-- integerToBitVector 5 -- End :. One :. Zero :. One
-- integerToBitVector 7 -- End :. One :. One :. One
integerToBitVector :: Integer -> BitVector
integerToBitVector 0 = End
integerToBitVector n
  | n `rem` 2 == 0 = rec Zero
  | otherwise = rec One
  where rec bit = integerToBitVector (n `div` 2) :. bit

-- Convert a BitVector to a number
-- EXAMPLES:
-- bitVectorToInteger  0 -- End
-- bitVectorToInteger End :. One :. Zero :. Zero :. Zero :. One :. Zero :. One
--                    -> 16
-- bitVectorToInteger End :. One :. Zero :. Zero :. Zero :. Zero -- 16
bitVectorToInteger :: BitVector -> Integer
bitVectorToInteger = (bitVectorToInteger' 0) . canonicalise

bitVectorToInteger' :: Integer -> BitVector -> Integer
bitVectorToInteger' _ End = 0
bitVectorToInteger' n (bv :. One) = 2^n + bitVectorToInteger' (n + 1) bv
bitVectorToInteger' n (bv :. Zero) = bitVectorToInteger' (n + 1) bv
-- HINT: It would be easier to first canonicalise the bitvector

-- BitVector addition
-- You're not allowed to use the conversion functions!
-- You will need to do recursion on both the BitVectors when there are Ones here
-- to detect when overflow happens!
-- EXAMPLES:
-- addBitVector End (End :. One) -- End :. One
-- addBitVector (End :. Zero) End -- End :. Zero
-- addBitVector (End :. Zero) (End :. One) -- End :. One
-- addBitVector (End :. One) (End :. Zero) -- End :. One
-- addBitVector (End :. One :. Zero) (End :. One :. Zero :. Zero)
-- -> End :. One :. One :. Zero
addBitVector :: BitVector -> BitVector -> BitVector
addBitVector End bv = bv
addBitVector bv End = bv
addBitVector (bv1 :. bit1) (bv2 :. bit2)
  = case (bit1, bit2) of
      (Zero, Zero) -> addBitVector bv1 bv2 :. Zero
      (One, One)   -> addBitVector (succBitVector bv1) bv2 :. Zero
      _            -> addBitVector bv1 bv2 :. One


---------------------
-- SOME MORE LISTS --
---------------------

-- Checks if a list of lists is a square
isSquareMatrix :: [[a]] -> Bool
isSquareMatrix xss = all ((==length xss) . length) xss

-- Get the main diagonal of a matrix
mainDiag :: [[a]] -> [a]
mainDiag [] = []
mainDiag ([]:_) = []
mainDiag ((y:_):xs) = y : mainDiag (map tail xs)

-- Get the secondary diagonal of a matrix
secondaryDiag :: [[a]] -> [a]
secondaryDiag = mainDiag . reverse

-- (a,b,c) is a pythgorean triplet when a^2 + b^2 = c^2
-- Find the first n such
pythagoreanTriples :: Int -> [(Int, Int, Int)]
pythagoreanTriples n
  = take n [(a,b,c) | a<-[1..], b<-[1..a], c<-[1..a], p a b c]
  where p x y z = x^2 == y^2 + z^2
