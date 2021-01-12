import Ex12

res :: [String]
res = specialSort ["moo", "bee", "eve", "abracadabra", "abcdefg", "mama", "z"]

testTree :: IntTree
testTree = Node 5
                (Node 12
                      Empty
                      (Node 9 Empty Empty))
                (Node (-6)
                      (Node 20 Empty Empty)
                      (Node 2 Empty Empty))