import Prelude

-- Staticly vs Dynamicly typed languages

-- Function Signatures
-- (define a 5)


-- int a = 5;
a :: Int
a = 5

mySum :: Int -> Int -> Int
mySum a b = a + b

-- voidFunction :: Int -> IO () -- () == void

-- GHCi features

-- Pattern Matching

-- (define (factorial n)
--   (if (= n 0)
--   1
--   (...)))
factorial :: Int -> Int
factorial n = if n == 0 then 1 else (factorial (n - 1)) * n

fact :: Int -> Int
fact 0 = 1
fact n = n * (fact (n - 1))

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

-- Demo with factorial/fibonacci

-- if/then/else
-- head/tail - car/cdr
sumElements :: [Int] -> Int
sumElements xs = if null xs then 0 else (head xs) + sumElements (tail xs)

-- empty list pattern - []
sumElements' :: [Int] -> Int
sumElements' [] = 0
sumElements' xs = head xs + sumElements' (tail xs)

-- non-empty list pattern - (x:xs)
-- x is the first element
-- the rest are found in xs
sumElements'' :: [Int] -> Int
sumElements'' [] = 0
sumElements'' (x:xs) = x + sumElements'' xs

-- if we don't care about the current element
-- replace with _
len :: [a] -> Int
len [] = 0
len (_:xs) = 1 + len xs

-- change all elements of the list to 1
-- and find the sum
len' :: [a] -> Int
len' xs = sumElements [ 1 | x <- xs]

-- guard - complex patterns that cannot be captured
-- in the regular pattern matching
-- such as n < 0
-- works the same way as cond in scheme
countDigits :: Int -> Int
countDigits n
countDigits n
  |n < 0 = countDigits (- n)
  |n < 10 = 1
  |otherwise = 1 + countDigits (n `div` 10)
-- ^ guards

-- && || not

-- mod/div = remainder/quotient

