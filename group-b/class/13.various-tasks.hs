-- import Prelude hiding (replicate)

-- allEqual - функция, която ни казва дали всички елементи от списък са еднакви
allEqual :: (Eq a) => [a] -> Bool
allEqual [] = True
allEqual [x] = True
allEqual (x:rest@(y:xs)) = x == y && allEqual rest

allEqual' :: (Eq a) => [a] -> Bool
allEqual' [] = True
allEqual' (x:xs) = foldl (&&) True $ map (== x) xs -- [True, True, True]
-- allEqual' (x:xs) = and $ map (== x) xs -- [True, True, True]


allEqual'' :: (Eq a) => [a] -> Bool
allEqual'' [] = True
allEqual'' all@(x:xs) = replicate (length all) x == all

-- split - функция, която приема String и Char и разделя низа според разделителния знак
-- например: split "abc,def,ghi" ',' == ["abc", "def", "ghi"]
--           split "abc,def,ghi" ';' == ["abc,def,ghi"]
--           split "abc;def,ghi" ';' == ["abc", "def,ghi"]
split :: (Eq a) => [a] -> a -> [[a]]
split [] _ = []
split xs sep = untilFirstSeparator : split rest sep
  where  untilFirstSeparator = takeWhile (/= sep) xs 
         rest = case dropWhile (/= sep) xs of
                 [] -> []
                 (_:xs) -> xs


-- join - функция, която приема списък от Strings и Char и прави един низ, като между всеки елемент
-- от списъка добавя разделителния знак
-- например: join ["abc", "def", "ghi"] ',' == "abc,def,ghi"
--           join ["abc", "def", "ghi"] '' == "abcdefghi"
join :: [[a]] -> a -> [a]
join [] _ = []
join [x] _ = x
join (x:xs) sep = x ++ [sep] ++ (join xs sep)


-- splitByN - функция, която разделя списък на равни части с дадена големина
-- например: splitByN [1..6] 2 == [[1,2],[3,4],[5,6]]
--           splitByN [1..6] 4 == [[1,2,3,4],[5,6]]
--           splitByN [1..6] 7 == [[1,2,3,4,5,6]]
--           splitByN [1..6] 1 == [[1],[2],[3],[4],[5],[6]

splitByN :: [a] -> Int -> [[a]]
splitByN [] _ = []
splitByN xs n = take n xs : (splitByN (drop n xs) n)


-- replicate - функция, която приема списък и число и ни връща списък, но всеки елемент от
-- оригиналния е повторен колкото даденото число
-- например: replicate [1..5] 2 == [1,1,2,2,3,3,4,4,5,5]
--           replicate [1..3] 4 == [1,1,1,1,2,2,2,2,3,3,3,3]
myReplicate :: [a] -> Int -> [a]
myReplicate [] _ = []
myReplicate (x:xs) n = replicate n x ++ myReplicate xs n


-- transpose - функция, която транспонира дадена матрица
-- [[1,2,3]
--  [4,5,6]
--  [7,8,9]]
--

-- [[3],
--  [6],
--  [9]]
--
--  [[],
--   [],
--   []]
transpose :: [[a]] -> [[a]]
transpose [] = []
transpose m
  |all null m = []
  |otherwise = (map head m) : transpose (map tail m)

-- permutations - функция, която ни дава всички пермутации на даден списък
-- [1,2,3] -> [[1,2,3], [1,3,2], [2,1,3], [2,3,1]...]
permutations :: (Eq a) => [a] -> [[a]]
permutations [] = [[]]
permutations xs = [x : rest| x <- xs, rest <- permutations $ xs `without` x]
  where xs `without` x = filter (/= x) xs



