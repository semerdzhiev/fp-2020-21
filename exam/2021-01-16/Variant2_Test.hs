module Variant2_Test where

import Variant2
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

positive = map (treeContains sample) ["", "a", "b", "abdg", "bd", "ae"]
negative = map (treeContains sample) ["ea", "zx", "abb"]

test_treeContains = "Tests for treeContains with the sample tree" ~: TestList [

    foldl1 (&&) positive ~? "existing words are recognized correctly",
    
    not (foldl1 (&&) negative) ~? "non-existing words are reported as such",

    not (treeContains EmptyTree "a") ~? "the empty tree contains no words"

  ]

test_isInjective = "Testing isInjective with interval [1,10]" ~: TestList [

    isInjective id 1 10 ~? "id is injective",

    isInjective (*10) 1 10 ~? "(*10) is injective",

    not (isInjective (`rem` 6) 1 10) ~? "(`rem` 6) is NOT injective"

  ]

main = do
    runTestTT test_treeContains
    runTestTT test_isInjective  
