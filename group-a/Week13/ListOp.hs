module ListOp
  ( map'
  ) where

map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (head:tail) = (f head) : map' f tail
