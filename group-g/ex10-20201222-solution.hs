-- В този файл има предимно примери за синтаксиса на хаскел

-- if-then-else is an expression
--fib n = if n < 2 then n else fib (n-1) + fib (n-2)

{- гардове (guards):
fib n
  | n < 2     = n
  | otherwise = fib (n-1) + fib (n-2)
-}

{- pattern matching:
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)
-}

-- more pattern matching
isA 'a' = True
isA 'A' = True
isA _ = False

-- foo 0 _ = "iei"
-- foo _ 0 = "bah"
-- foo x y = ...

fib n = case n of 0 -> 0
                  1 -> 1
                  _ -> fib (n-1) + fib (n-2)


-- local definitions with "let" are clumsy
foo x = (let y = fib x in if y > 100 then y else 42)

-- local definitions with "where" are superior
bar x = if x > 100 then y else 42
  where y = fib x -- мързеливо оценявано - няма да се изчисли ако не се използва (напр. x<=100)
        z = 2*(fact y) + x
        fact 0 = 1
        fact n = n * fact (n-1)

-- pattern matching за наредени двойки/n-торки
--complAdd p1 p2 = (fst p1 + fst p2, snd p1 + snd p2)
complAdd (x1,y1) (x2,y2) = (x1+x2,y1+y2)

-- комбинация от pattern matching за най-простите случаи
-- и гардове за малко по-сложните + where за локални дефиниции
fastPow _ 0 = 1
fastPow x 1 = x
fastPow x n
  | even n    = half*half
  | otherwise = half*half*x
  where half = fastPow x (n `div` 2)

-- ламбда функции
repeated _ 0 = \x -> x
repeated f n = \x -> f ((repeated f (n-1)) x)

--length' lst = if null lst then 0 else 1 + length' (tail lst)

-- можем да pattern match-ваме списъци по техните
-- съставни части (а именно, главата и опашката)
length' [] = 0
length' (_:xs) = 1 + length' xs
