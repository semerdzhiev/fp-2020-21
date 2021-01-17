module Variant2 where

import Data.List (nub)

data Tree a = EmptyTree | Node {
                            value :: a,
                            left  :: Tree a,
                            right :: Tree a
                          } deriving (Show,Read)

treeContains:: Tree Char -> String -> Bool
treeContains _ "" = True
treeContains EmptyTree str = False
treeContains (Node v l r) str@(c:cs) | c == v    = treeContains l cs  || treeContains r cs
                                     | otherwise = treeContains l str || treeContains r str

isInjective :: Integral t => (t -> t) -> t -> t -> Bool
isInjective f a b = pr == nub pr
    where pr = [f x | x <- [a..b]] -- проекцията на [a,b]
