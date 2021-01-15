-- import qualified ListOp as Op
import Data.List
import System.IO
import Control.Monad

-- f = Op.map' (\x -> x + 1) [1..10]

-- instance Functor [] where
--   fmap = map


-- instance Functor Maybe where
--   fmap _ Nothing = Nothing
--   fmap f (Just a) = Just (f a)


-- data Maybe a = Just a | Nothing
-- data Either a b = Left a | Right b

-- <- return

readNonEmptyLine :: IO (Maybe String)
readNonEmptyLine = do
  theLine <- getLine
  if (length theLine) == 0
    then return Nothing
    else return (Just theLine)

main :: IO ()
main = do
  mapM_ print [1..10]
