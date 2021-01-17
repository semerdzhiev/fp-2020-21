module Variant1_Test where

import Variant1
import Data.List (intersect)
import Test.HUnit

{-- sample tree from the exam
    a
   / \
  b   c
 / \   \
d   e   f
 \
  g
--}

sample1 = Node 'a' (Node 'b' (Node 'd' EmptyTree
                                       (Node 'g' EmptyTree EmptyTree))
                             (Node 'e' EmptyTree EmptyTree))
                   (Node 'c' EmptyTree
                             (Node 'f' EmptyTree EmptyTree))

{-- sample tree2: the prefix of the word "abdg" also exists as a separate word "abd" in the tree
    a
   / \
  b   b
 / \   \
d   e   d
 \
  g
--}

sample2 = Node 'a' (Node 'b' (Node 'd' EmptyTree
                                       (Node 'g' EmptyTree EmptyTree))
                             (Node 'e' EmptyTree EmptyTree))
                   (Node 'b' EmptyTree
                             (Node 'd' EmptyTree EmptyTree))

test_treeWords = "Tests for treeWords" ~: TestList [

  "treeWords works correctly for sample1" ~:
    ["abdg","abe","acf"] ~=? (["abdg","abe","acf"] `intersect` (treeWords sample1)),

  "treeWords works correctly for sample2" ~:
    ["abdg","abe","abd"] ~=? (["abdg","abe","abd"] `intersect` (treeWords sample2)),

  "treeWords works correctly for the empty tree" ~:
    [] ~=? treeWords EmptyTree

  ]

test_mapsTo = "Testing mapsTo with interval [1,10]" ~: TestList [

  "id maps to [1,10]" ~:
    (1,10) ~=? mapsTo id 1 10,

  "(*10) maps to [10,100]" ~:
    (10,100) ~=? mapsTo (*10) 1 10,

  "f(x)=1 maps to [1,1]" ~:
    (1,1)  ~=? mapsTo (\x->1) 1 10
  
  ]

main = do
    runTestTT test_treeWords
    runTestTT test_mapsTo   
