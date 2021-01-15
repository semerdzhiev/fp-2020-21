import Data.Word
import HUnit.Base

data Tree a =
  EmptyTree
  | Node { value :: a
         , left  :: Tree a
         , right :: Tree a
         } deriving (Show,Read)

data Strategy =
  Inorder
  | Postorder
  | Preorder deriving (Show,Read)

values :: Strategy -> (Tree a) -> [a]
values Inorder = inorder
values Postorder = postorder
values Preorder = preorder

leaf a = Node a EmptyTree EmptyTree

tree = Node 4 (Node 2 (leaf 11) (leaf 3))
              (Node 22 (leaf 21) (leaf 23))

inorder :: (Tree a) -> [a]
inorder EmptyTree = []
inorder (Node value left right) = (inorder left) ++ value : (inorder right)

preorder :: (Tree a) -> [a]
preorder EmptyTree = []
preorder (Node value left right) = value : (preorder left) ++ (preorder right)

postorder :: (Tree a) -> [a]
postorder EmptyTree = []
postorder (Node value left right) = (postorder left) ++ (postorder right) ++ [value]

{-
 -
 -
 -}

data Rgb = Rgb { red   :: Word8
               , green :: Word8
               , blue  :: Word8 } deriving (Show,Read)

data Image = Image { width   :: Int
                   , height  :: Int
                   , content :: [[Rgb]] } deriving (Show,Read)

image = Image { width = 2
              , height = 2
              , content = [[Rgb 12 32 21, Rgb 32 234 12]
                          ,[Rgb 87 223 212, Rgb 132 24 2]
                          ]
              }

grayscale :: Image -> Image
grayscale image@Image{content = content} =
  image {content = map (map rgbToGS) content}


rgbToGS (Rgb red green blue) =
  Rgb roundedGs roundedGs roundedGs
  where
    gs = (fromIntegral red) * 0.3 + (fromIntegral green) * 0.59 + (fromIntegral blue) * 0.11
    roundedGs = round gs

{-
 -
 -
 -}


-- 1 2 3 4 5 6 7 8 9 10 11
-- 1 2 2 3 3 4 4 4 5  5  5

s :: [Int]
s = 1:2:2:(genSequence 3 (s !! 2))

genSequence :: Int -> Int -> [Int]
genSequence n 0 = genSequence (n + 1) (s !! n)
genSequence n k = n : genSequence n (k - 1)

numS = zip [1..] s

type Assertion = IO ()

assertTrue _ True = Assertion
assertTrue name _ = writeStrLn name ++ ": failed!\nassertTrue given False"

data Test =
  TestCase Assertion
  | TestList [Test]
  | TestLable String Test

withLables [] test = test
withLables a:b test = TestLable a (withLables b test)

main = runTestTT
TestLable "Testing Trivial"
          TestList [TestCase asertTrue "should faile" False
                   ,TestCase asertTrue "should pass" True
                   ]
