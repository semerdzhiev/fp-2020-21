import Data.Maybe (isJust, isNothing)
import Data.List (isPrefixOf)

-- Зад.3.
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeTail :: [a] -> Maybe [a]
safeTail []     = Nothing
safeTail (_:xs) = Just xs

safeUncons :: [a] -> Maybe (a, [a])
safeUncons []     = Nothing
safeUncons (x:xs) = Just (x,xs)

findIndex :: Eq a => a -> [a] -> Maybe Int
findIndex _ [] = Nothing
findIndex x (y:ys)
  | x == y                       = Just 0
  | (Just idx) <- findIndex x ys = Just (1 + idx) -- some weird pattern matching here
  | otherwise                    = Nothing

stripPrefix :: Eq a => [a] -> [a] -> Maybe [a]
stripPrefix lst1 lst2
  | lst1 `isPrefixOf` lst2 = Just $ drop (length lst1) lst2
  | otherwise              = Nothing

stripPrefix' :: Eq a => [a] -> [a] -> Maybe [a]
stripPrefix' [] lst2 = Just lst2
stripPrefix' lst1 [] = Nothing
stripPrefix' (x:xs) (y:ys)
  | x == y    = stripPrefix' xs ys
  | otherwise = Nothing

maybeToList' :: Maybe a -> [a]
maybeToList' Nothing  = []
maybeToList' (Just x) = [x]

mapMaybe' :: (a -> b) -> Maybe a -> Maybe b
mapMaybe' _ Nothing  = Nothing
mapMaybe' f (Just x) = Just (f x)

-- template <typename a>
-- class Tree {
-- ...
-- }
data Tree a = Empty
            | Node a (Tree a) (Tree a)

-- после ползваме инстанциран шаблон, напр. Tree<int>
testTree :: Tree Int
testTree = Node 5
                (Node 6 Empty Empty)
                (Node (-10)
                      (Node 2 Empty Empty)
                      Empty)

-- Зад.5.
maxSumPath :: (Num a, Ord a) => Tree a -> a
maxSumPath Empty = 0
maxSumPath (Node val left right) = val + max (maxSumPath left) (maxSumPath right)

-- Зад.6.
prune :: Tree a -> Tree a
prune Empty = Empty
prune (Node _ Empty Empty) = Empty
prune (Node val left right) = Node val (prune left) (prune right)
-- Очакваният резултат за prune testTree
pruned :: Tree Int
pruned = Node 5
              Empty
              (Node (-10)
                    Empty
                    Empty)

-- Зад.7.
bloom :: Tree a -> Tree a
bloom Empty = Empty
bloom t@(Node val Empty Empty) = Node val t t
bloom (Node val left right) = Node val (bloom left) (bloom right)
-- Очакваният резултат за bloom testTree
bloomed :: Tree Int
bloomed = Node 5
               (Node 6
                     (Node 6 Empty Empty)
                     (Node 6 Empty Empty))
               (Node (-10)
                     (Node 2
                           (Node 2 Empty Empty)
                           (Node 2 Empty Empty))
                     Empty)

-- Зад.8.
rotateLeft, rotateRight :: Tree a -> Tree a
rotateLeft (Node p a (Node q b c)) = Node q (Node p a b) c
rotateLeft t = t -- понякога не се налага, но е хубаво да присъства. Може и да връща error
rotateRight (Node q (Node p a b) c) = Node p a (Node q b c)
rotateRight t = t

--data Maybe a = Nothing
--             | Just a

-- Бонус: няколко подхода за проверка за балансираност
-- с двукратно обхождане на дървото
balanced :: Tree a -> Bool
balanced Empty = True
balanced (Node _ left right) = balanced left && balanced right
    && abs (height left - height right) <= 1
  where height = undefined -- to-do

-- с връщане на наредена двойка
balanced' :: Tree a -> Bool
balanced' t = fst $ helper t
  where helper :: Tree a -> (Bool, Int)
        helper Empty = (True, 0)
        helper (Node _ left right)
          | leftBal && rightBal && abs (leftH-rightH) <= 1 = (True, h)
          | otherwise                                      = (False, h)
          where (leftBal, leftH) = helper left
                (rightBal, rightH) = helper right
                h = 1 + max leftH rightH

-- с връщане на "специална стойност" (неприложимо в някои случаи)
balanced'' :: Tree a -> Bool
balanced'' t = helper t >= 0
  where helper :: Tree a -> Int
        helper Empty = 0
        helper (Node _ left right)
          | leftH >= 0 && rightH >= 0 && abs (leftH-rightH) <= 1 = h
          | otherwise                                            = (-1)
          where leftH = helper left
                rightH = helper right
                h = 1 + max leftH rightH

-- с Maybe
balanced''' :: Tree a -> Bool
balanced''' t = isJust (helper t)
  where -- връща (Just височината) ако е балансирано
        -- връща Nothing иначе
        helper :: Tree a -> Maybe Int
        helper Empty = Just 0
        helper (Node _ left right) = 
            case (helper left, helper right) of (Just lh, Just rh) -> Just (1 + max lh rh)
                                                _ -> Nothing

-- Зад.9.
treeMap :: (a -> b) -> Tree a -> Tree b
treeMap _ Empty = Empty
treeMap f (Node val left right) = Node (f val) (treeMap f left) (treeMap f right)

-- Зад.10
instance Functor Tree where
  fmap = treeMap -- :)

-- Зад.11.
-- Заб.: конструкторите трябва да са с различни имена от тези за нормално дърво
data BST a = BSTEmpty
           | BSTNode a (BST a) (BST a)

------------------
-- Пример за работа с графи - обхождане в дълбочина, откриване на цикли и топологично сортиране

-- typedef [[Int]] Graph;
-- using Graph = [[Int]];
type Graph = [[Int]]

testGraph :: Graph
testGraph = [[1,2]
            ,[2,5]
            ,[3]
            ,[5]
            ,[]
            ,[4]
            ]

graphSize :: Graph -> Int
graphSize = length

neighbs :: Int -> Graph -> [Int]
neighbs u g = g !! u

-- DFS
-- 1. colors = replicate n White
-- 2. foreach u in [0..n-1]
-- 3.   if colors[u] == White
-- 4.     DFSVisit u g
-- Проблем: colors се променя от извикванията на DFSVisit
-- => трябва да ѝ го подаваме, а тя да връща новата стойност
-- => решение - ще използваме foldl (или foldr), на който ще подадем първоначалната
--    стойност на масива и ще го "поддържаме" от итерация на итерация
-- foldl (+) 0 [1,2,3] <=> (((0+1)+2)+3)

-- DFSVisit
-- 1. colors[u] = Gray
-- 2. foreach v in neighbs u
-- 3.   if colors[v] == White
-- 4.     DFSVisit v g
-- 5.   else if colors[v] == Gray
-- 6.     има цикъл => няма топологично сортиране
-- 7. colors[u] = Black
-- 8. добавяме връх u отдясно-наляво в списъка със топологично сортирани върхове
-- Същият проблем -> същото решение :)

data Color = White | Gray | Black deriving (Show)
-- Масивът с цветове е нашето "състояние", което поддържаме грижливо
type State = [Color]

update :: Int -> a -> [a] -> [a]
update idx val lst = (take idx lst) ++ (val:drop (idx+1) lst)
-- update 'x' 2 "abcde" = "ab" ++ ('x':"de") = "abxde"

-- Просто обхождане, връщаме окончателната стойност на масива с цветове
-- Би трябвало да е идентична с (replicate n Black)
dfs g = foldl helper (replicate n White) [0..n-1]
  where n = graphSize g
        helper :: State -> Int -> State
        helper colors u =
          case colors !! u of White -> dfsVisit u colors
                              _     -> colors
        dfsVisit :: Int -> State -> State
        dfsVisit u colors = let colors' = foldl helper' (update u Gray colors) (neighbs u g)
                            in update u Black colors'
          where helper' :: State -> Int -> State
                helper' colors v =
                  case colors !! v of White -> dfsVisit v colors
                                      _     -> colors
        

-- Откриване на цикли, т.е. възможност за "провал" на обхождането
-- -> енкапсулираме състоянието в Maybe, за да може
-- да прекратим обхождането при срещане на цикъл
hasCycles :: Graph -> Bool
hasCycles g = isNothing $ foldl helper (Just $ replicate n White) [0..n-1]
  where n = graphSize g
        helper :: Maybe State -> Int -> Maybe State
        helper (Just colors) u =
          case colors !! u of White -> dfsVisit u colors
                              Gray  -> error "Something ain't right"
                              Black -> Just colors
        helper Nothing _ = Nothing -- тук пропускаме итерация на цикъла, т.е. DFSVisit за текущото u
        dfsVisit :: Int -> State -> Maybe State
        dfsVisit u colors =
            case foldl helper' (Just $ update u Gray colors) (neighbs u g) -- промените преди цикъла са тук
            of (Just colors') -> Just $ update u Black colors' -- промените след цикъла са тук
               Nothing        -> Nothing
          where helper' :: Maybe State -> Int -> Maybe State
                helper' (Just colors) v =
                  case colors !! v of White -> dfsVisit v colors
                                      Gray  -> Nothing -- намерен е цикъл
                                      Black -> Just colors
                helper' Nothing _ = Nothing

-- Ако искаме да върнем и резултат (списък с върховете в топологичен ред),
-- който резултат се попълва по време на обхождането -> добавяме го към "състоянието".
-- Който студент пръв реши това с монадата State (и евентуално Error), ще получи бонус към финалната оценка :)
type NewState = ([Color], [Int])
topoSort :: Graph -> Maybe [Int]
topoSort g = case foldl helper (Just (replicate n White, [])) [0..n-1]
             of Just (_, res) -> Just res
                _             -> Nothing
  where n = graphSize g
        helper :: Maybe NewState -> Int -> Maybe NewState
        helper (Just s@(colors, _)) u =
          case colors !! u of White -> dfsVisit u s
                              Gray  -> error "Something ain't right"
                              Black -> Just s
        helper Nothing _ = Nothing
        dfsVisit :: Int -> NewState -> Maybe NewState
        dfsVisit u (colors, res) =
          case foldl helper' (Just $ (update u Gray colors, res)) (neighbs u g) -- промените преди цикъла са тук
          of (Just (colors', res)) -> Just $ (update u Black colors', u:res) -- промените след цикъла са тук
             Nothing               -> Nothing
          where helper' :: Maybe NewState -> Int -> Maybe NewState
                helper' (Just s@(colors, _)) v =
                  case colors !! v of White -> dfsVisit v s
                                      Gray  -> Nothing -- намерен е цикъл
                                      Black -> Just s
                helper' Nothing _ = Nothing

