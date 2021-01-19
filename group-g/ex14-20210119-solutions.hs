{-# LANGUAGE InstanceSigs #-} -- позволява да пишем сигнатурите на
-- функциите от инстанцираните класове с цел улеснено разбиране :)
import Data.List ((\\))

-- Зад.1.
data BST a = BSTEmpty
           | BSTNode a (BST a) (BST a) deriving Show

bstSize :: BST a -> Int
bstSize BSTEmpty = 0
bstSize (BSTNode _ l r) = 1 + bstSize l + bstSize r

bstInsert :: Ord a => a -> BST a -> BST a
bstInsert x BSTEmpty = BSTNode x BSTEmpty BSTEmpty
bstInsert x (BSTNode y l r)
  | x < y     = BSTNode y (bstInsert x l) r
  | otherwise = BSTNode y l (bstInsert x r)

bstValues :: BST a -> [a]
bstValues BSTEmpty = []
bstValues (BSTNode x l r) = bstValues l ++ (x:bstValues r)

bstFromList :: Ord a => [a] -> BST a
bstFromList = foldr bstInsert BSTEmpty

bstSort :: Ord a => [a] -> [a]
bstSort = bstValues . bstFromList

-- Зад.2.

data Direction = L | R deriving Show

-- Вариация на функцията от миналото упр.
rotate :: Direction -> BST a -> BST a
rotate L (BSTNode p a (BSTNode q b c)) = BSTNode q (BSTNode p a b) c
rotate R (BSTNode q (BSTNode p a b) c) = BSTNode p a (BSTNode q b c)

-- Изтриване в два етапа:
-- 1. идентифицираме поддървото с корен търсения елемент
-- 2. на това дърво изтриваме корена, избутвайки го до листо и "отрязвайки" листото 
bstDelete :: Ord a => a -> BST a -> BST a
bstDelete _ BSTEmpty = BSTEmpty
bstDelete x t@(BSTNode y l r)
  | x == y    = deleteRoot t
  | x < y     = BSTNode y (bstDelete x l) r
  | otherwise = BSTNode y l (bstDelete x r)

-- Инварианта: никога няма да я извикваме за празно дърво
deleteRoot :: BST a -> BST a
-- Търсената стойност е листо - окастряме го
deleteRoot (BSTNode _ BSTEmpty BSTEmpty) = BSTEmpty
-- Оптимизация - ако няма ляво поддърво, след една ротация стойността за изтриване ще е листо
deleteRoot t@(BSTNode _ BSTEmpty _) = let (BSTNode y l r) = rotate L t
                                      in BSTNode y (deleteRoot l) r
-- Аналогично за случая, в който дясното поддърво е празно (или каквото и да е)
deleteRoot t = let (BSTNode y l r) = rotate R t
               in BSTNode y l (deleteRoot r)

-- Построява дърво по стойностите от даден списък, премахва една от тях
-- и проверява дали полученото дърво е валидно.
testInsertDelete :: Ord a => [a] -> Bool
testInsertDelete lst = isSorted newLst && (lst \\ newLst == [head lst])
  where newLst = bstValues . bstDelete (head lst) . bstFromList $ lst
        isSorted (x:y:xs) = x <= y && isSorted (y:xs)
        isSorted _ = True

-- Зад.4.
-- mapMaybe от миналото упражнение го имаме вградено,
-- като част от инстанцирането на класа Functor от Maybe
-- instance Functor Maybe where
--   fmap _ Nothing = Nothing
--   fmap f (Just x) = Just (f x)
--   (<$>) = fmap -- Инфиксен вариант

bstPath :: Ord a => a -> BST a -> Maybe [Direction]
bstPath _ BSTEmpty = Nothing
bstPath x (BSTNode y l r)
  | x == y = Just []
  | x < y  = (L:) <$> (bstPath x l)
  | otherwise = (R:) <$> (bstPath x r)

-- Зад.5.
data Operation = Plus | Minus | Mult | Div
instance Show Operation where
  show Plus = "+"
  show Minus = "-"
  show Mult = "*"
  show Div = "/"

toFunction :: Operation -> Double -> Double -> Double
toFunction Plus = (+)
toFunction Minus = (-)
toFunction Mult = (*)
toFunction Div = (/)

data Expr = Var
          | Value Double
          | BinaryOp Operation Expr Expr

instance Show Expr where
  show Var = "x"
  show (Value v) = show v
  show (BinaryOp op e1 e2) = "(" ++ show e1 ++ show op ++ show e2 ++ ")"

eval :: Expr -> Double -> Double
eval Var x = x
eval (Value v) _ = v
eval (BinaryOp op e1 e2) x = (toFunction op) (eval e1 x) (eval e2 x)

collapse :: Expr -> Expr
collapse (BinaryOp op e1 e2) =
  case (e1', e2') of (Value x1, Value x2) -> Value ((toFunction op) x1 x2)
                     _ -> BinaryOp op e1' e2'
  where e1' = collapse e1; e2' = collapse e2
collapse e = e -- values & variables do not collapse

-- (x-((1*3)+2))+(4/2) <=> (x-5)+2
testExpr :: Expr
testExpr = BinaryOp Plus
                    (BinaryOp Minus
                              Var
                             (BinaryOp Plus
                                       (BinaryOp Mult (Value 1) (Value 3))
                                       (Value 2)))
                    (BinaryOp Div (Value 4) (Value 2))
