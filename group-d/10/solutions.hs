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


-- за списък от цели числа, премахва дубликатите,
-- т.е. запазва само първите срещания на даден елемент
nub :: (Eq a) => [a] -> [a]
nub [] = []
nub (x:xs) = x : (nub $ filter (/=x) xs)

-- Проверява дали число е просто
prime :: Int -> Bool
prime n = null [x | x<-[2..n-1], n `rem` x == 0]

-- За дадено число n връща списък от първите n прости (положителни) числа
primes :: Int -> [Int]
primes n = take n $ filter prime [2..]

-- Помощна за factorize
-- За n и d връща списък от повторения на d,
-- в зависимост колко пъти n се дели на d
-- listDivisors 18 3 = [3,3]
listDivisors :: Int -> Int -> [Int]
listDivisors 0 _ = []
listDivisors n d
  | n `rem` d /= 0 = []
  | otherwise = d : listDivisors (n `quot` d) d

-- За дадено естествено число, връща списък от простите му делители
-- factorize 60 = [2, 2, 3, 5]
-- 2*2*3*5 = 60
factorize :: Int -> [Int]
factorize n = concatMap (listDivisors n) ps
  where ps = takeWhile (<=n`div`2) $ primes n

-- quicksort за цели числа
-- Няма нужда да взимаме случаен елемент
-- просто можем да вземем първия
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (x:xs) =  lower ++ [x] ++ higher
  where lower = quicksort [y | y<-xs, y <= x]
        higher = quicksort [y | y<-xs, y > x]
