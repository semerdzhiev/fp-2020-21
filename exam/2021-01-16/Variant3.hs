module Variant3 where

import Data.List((\\))

data Tree a = EmptyTree | Node {
                            value :: a,
                            left  :: Tree a,
                            right :: Tree a
                          } deriving (Show,Read)

combine:: [String] -> [String] -> [String]
combine xs [] = xs
combine [] ys = ys
combine (x:xs) (y:ys) = (x ++ y) : combine xs ys

treeLevels :: Tree Char -> [String]
treeLevels EmptyTree = []
treeLevels (Node v l r) = [v] : combine ll lr
    where ll = treeLevels l
          lr = treeLevels r

isSurjective :: Integral t => (t -> t) -> t -> t -> t -> t -> Bool
isSurjective f a b c d = null ([c..d] \\ pr)
    where pr = [f x | x <- [a..b]] -- проекцията на [a,b]
