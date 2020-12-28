fib :: Int -> Int
fib 1 = 1
fib 2 = 1
fib n = fib (n - 1) + fib (n - 2)

fact :: Integer -> Integer
fact 0 = 1
fact n = n * fact (n - 1)

sum_list :: [Integer] -> Integer
sum_list [] = 0
sum_list (head:tail) = head + sum_list tail


sum_list' :: [Integer] -> Integer
sum_list' list =
  if list == []
  then 0
  else head list + (sum_list' $ tail list)



is_prime :: Integer -> Bool
is_prime 1 = False
is_prime 2 = True
is_prime 3 = True
is_prime 5 = True
is_prime n
  | n < 1 = f
  | even n = f
  | True = length [x | x <- [3, 5..(n - 1)], n `mod` x == 0] == 0
  where
    f = False



primes = [x | x <- [1..], is_prime x]
