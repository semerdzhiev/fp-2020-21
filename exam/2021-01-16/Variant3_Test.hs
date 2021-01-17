module Variant3_Test where

import Variant3
import Test.HUnit

{-- sample tree from the homework
    a
   / \
  b   c
 / \   \
d   e   f
 \
  g
--}

sample = Node 'a' (Node 'b' (Node 'd' EmptyTree
                                      (Node 'g' EmptyTree EmptyTree))
                            (Node 'e' EmptyTree EmptyTree))
                  (Node 'c' EmptyTree
                            (Node 'f' EmptyTree EmptyTree))

test_treeLevels = "Tests for treeLevels" ~: TestList [
  
  "treeLevels works correctly for the sample tree" ~:
    ["a","bc","def","g"] ~=? treeLevels sample,
  
  "treeLevels works correctly for the empty tree" ~:
    [] ~=? treeLevels EmptyTree

  ]

test_isSurjective = "Testing isSurjective with intervals [1,10] and [1,5]" ~: TestList [

    isSurjective id 1 10 1 5~? "id is surjective",

    not (isSurjective (*10) 1 10 1 5) ~? "(*10) is NOT surjective",

    isSurjective (`rem` 6) 1 10 1 5 ~? "(`rem` 6) is surjective"

  ]

main = do
    runTestTT test_treeLevels
    runTestTT test_isSurjective
