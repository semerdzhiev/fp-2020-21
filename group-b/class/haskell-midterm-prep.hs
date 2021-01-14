import Data.List (nub)
-- sumLast init n - безкраен поток, който започва с init, а всеки следващ елемент е сума на последните n от потока
-- sumLast 3 5 → [3, 3, 6, 12, 24, 48, 93, 183, ... ]
sumLast :: Int -> Int -> [Int]
sumLast initial n =  initial : generate [initial]
  where generate memory = sum memory : generate (sum memory : if length memory >= n then init memory else memory)

-- Да се напише функция transformSum, която преобразува дърво с елементи цели числа в ново дърво със същата структура,
-- в което всеки елемент е заменен със сумата на елементите в поддървото с този корен в началното дърво.
-- '(1 (3 () ()) (4 (5 () ()) 6)) -> '(19 (3 () ()) (15 (5 () ()) 6))
data Tree a = Empty | Tree a (Tree a) (Tree a) deriving Show

instance Foldable Tree where
  foldr _ nv Empty = nv
  foldr op nv (Tree root left right) = foldr op (op root (foldr op nv left)) right

test :: Tree Int
test = Tree 5 (Tree 10 Empty Empty) (Tree 3 Empty Empty)

transformSum :: Tree Int -> Tree Int
transformSum (Tree root left right) = Tree (root + sum left + sum right) (transformSum left) (transformSum right)
transformSum _ = Empty


-- Да се генерират всички подсписъци на даден такъв
-- [1,2,3] -> [[1,2,3],[1,2],[2,3],[1],[2],[3]]
-- prefixes = [1,2,3], [1,2], [1]
-- suffixes of [1,2,3] = [1,2,3], [2,3], [3]
-- suffixes of [1,2] = [1,2], [2]
-- suffixes of [1] = [1]
subsequences :: [a] -> [[a]]
subsequences [] = []
subsequences xs = [] : [suffix | prefixes <- inits xs, suffix <- tails prefixes]
  where inits [] = []
        inits xs = xs : inits (init xs)
        tails [] = []
        tails xs = xs : tails (tail xs)

subsequences' :: (Eq a) => [a] -> [[a]]
subsequences' [] = []
subsequences' xs = nub $ helper xs (length xs)
    where helper _ 0 = []
          helper [] _ = []
          helper xs n = chunk n xs ++ helper xs (n - 1)
          chunk _ [] = []
          chunk 0 _ = []
          chunk n xs = take n xs : chunk n (tail xs)

-- Да се генерира поток sumsOfCubes от тези числа, които са сума от кубовете на две положителни цели числа

sumOfCubes = [x^3 + y^3 | x <- [1..], y <- [1..]]

-- Път от корен до възел в двоично дърво кодираме с поредица от цифри 0 и 1, която започва с цифрата 1, а за всяка следваща цифра 0 означава завиване по левия клон, а 1 — по десния. Да се реализира функция sameAsCode, която в двоично дърво от числа връща такова число x, което съвпада по стойност с двоичното число, кодиращо пътя от корена до x, или 0, ако такова число няма. Представянето на дървото е по ваш избор.
