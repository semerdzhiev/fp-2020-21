module Variant1 where

data Tree a = EmptyTree | Node {
                            value :: a,
                            left  :: Tree a,
                            right :: Tree a
                          } deriving (Show,Read)

treeWords :: Tree Char -> [String]
treeWords EmptyTree = []
treeWords (Node v EmptyTree EmptyTree) = [[v]]
treeWords (Node v l r)  = map (v:) (wl ++ wr)
    where wl = treeWords l
          wr = treeWords r

mapsTo :: Integral t => (t -> t) -> t -> t -> (t,t)
mapsTo f a b = (minimum pr, maximum pr)
    where pr = [f x | x <- [a..b]] -- проекцията на [a,b]
