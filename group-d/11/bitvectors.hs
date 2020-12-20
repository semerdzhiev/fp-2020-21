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

-- | Before (with Nat) we had "unary" natural numbers,
-- they were encoded in a 1-ary counting system.
-- We can also represent natural numbers in a more familiar to you way - binary.

-- A binary number is a list of bits.
-- We will call this a BitVector.
data BitVector
  = End -- The empty bit vector, i.e. 0
  | BitVector :. Bit
  --          ^ we can have OPERATORS as constructor names
  -- This constructor adds another bit to the BitVector
  -- We put the bit on the right, because that's how we write them out on paper.
  -- Otherwise we will have to remember that the vector is "flipped"
  deriving Show


-- Examples for pattern matching:

isEnd :: BitVector -> Bool
isEnd End = True
isEnd (_ :. _) = False

-- 1101 -> 110
-- shiftRight (End :. One :. One :. Zero :. One)
-- shiftRight (bv                        :. One)
-- -> End :. One :. One :. Zero
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
succBitVector = undefined

-- Detect if a bitvector is zero
-- This is actually helpful for the next task
-- EXAMPLES:
-- isZero End -- True
-- isZero (End :. Zero :. Zero) -- True
-- isZero (End :. One :. Zero) -- False
-- isZero (End :. One) -- False
isZero :: BitVector -> Bool
isZero = undefined

-- A BitVector is said to be "canonical" if it has no leading zeroes.
-- Write a function to convert a BitVector to it's canonical form.
-- EXAMPLES:
-- canonicalise End -- End
-- canonicalise (End :. One :. Zero) -- End :. One :. Zero
-- canonicalise (End :. Zero :. Zero :. One :. Zero) -- End :. One :. Zero
canonicalise :: BitVector -> BitVector
canonicalise = undefined
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
integerToBitVector = undefined

-- Convert a BitVector to a number
-- EXAMPLES:
-- integerToBitVector 0 -- End
-- integerToBitVector 69
-- -> End :. One :. Zero :. Zero :. Zero :. One :. Zero :. One
-- integerToBitVector 16 -- End :. One :. Zero :. Zero :. Zero :. Zero
bitVectorToInteger :: BitVector -> Integer
bitVectorToInteger = undefined
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
addBitVector = undefined


---------------------
-- SOME MORE LISTS --
---------------------

-- Checks if a list of lists is a square
isSquareMatrix :: [[a]] -> Bool
isSquareMatrix = undefined

-- Get the main diagonal of a matrix
mainDiag :: [[a]] -> [a]
mainDiag = undefined

-- Get the secondary diagonal of a matrix
secondaryDiag :: [[a]] -> [a]
secondaryDiag = undefined

-- (a,b,c) is a pythgorean triplet when a^2 + b^2 = c^2
-- Find the first n such
pythagoreanTriples :: Int -> [(Int, Int, Int)]
pythagoreanTriples = undefined
