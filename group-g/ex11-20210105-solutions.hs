-- Зад.1
minimum' (x:xs) = foldl min x xs -- аналогично и с foldr и за maximum
--reverse' lst = foldr (\ el res -> res ++ [el]) [] lst -- квадратично (!)
reverse' lst = foldl (\ res el -> el:res) [] lst -- ламбдата е еквивалентна на (flip (:))
-- заб.: решенията за all и any са неоптимални (няма short circuit); аналогично и с foldl
all' p lst = foldr (\ el res -> p el && res) True lst
any' p lst = foldr (\ el res -> p el || res) False lst
append' lst1 lst2 = foldr (:) lst2 lst1
replicate' n x = foldr (\ _ res -> x : res) [] [1..n]

-- Зад.2
-- Да кажем, че броим само "същинските" делители
countDivisors n = length [ d | d<-[2..n-1], n `mod` d == 0]
prime n = (countDivisors n) == 0
descartes lst1 lst2 = [ (x,y) | x<-lst1, y<-lst2 ]

-- Зад.3
primes = filter prime [2..]

-- Зад.4
-- sieve няма клауза за празни списъци, следователно работи само върху
-- безкрайни такива. Т.к. тя е помощна функция и ние определяме как се
-- извиква (с безкрайния [2..]), това не е проблем.
primes' = sieve [2..]
  where sieve (x:xs) = x : sieve [ y | y<-xs, y `mod` x /= 0 ]

{-
Всеки следващ генератор отговаря на вложен цикъл в императивните езици
Ако някой вътрешен цикъл е безкраен, то ще забием завинаги в него
и няма да преминем на следващите итерации на външиния
[ (x,y) | x<-[0..], y<-[0..] ]
  съответства грубо на:
for (x = 0; ; ++x) {
    for (y = 0; ; ++y) {
        ...
    }
}

Решение: ще генерираме наредените двойки по "диагонали":
(0,0) (1,0) (2,0) (3,0) (4,0) ...
(0,1) (1,1) (2,1) (3,1) ...
(0,2) (1,2) (2,2) (3,2) ...
(0,3) (1,3) (2,3) ...
...
-> [(0,0),(1,0),(0,1),(2,0),(1,1),(0,2),(3,0),(2,1),(1,2),(0,3), ...
-}
-- Зад.5: във всеки диагонал с индекс d индексираме елементите с i от 0 до d, вкл.
-- Така само най-външният генератор (все едно цикъл) е безкраен
pairs = [ (d-i,i) | d<-[0..], i<-[0..d] ]

-- Зад.6: можем да започнем с най-голямата страна и да ограничим другите до нея
pyths = [ (a,b,c) | c<-[5..], b<-[1..c-1], a<-[1..b-1], a^2 + b^2 == c^2 ]

-- Зад.7
compress [] = []
compress lst = (head lst, length heads) : compress rest
  where (heads,rest) = span (\x -> x == head lst) lst

-- Зад.8: няколко вариращи по четимост решения
--maxRepeated lst = foldr (\ (_,n) res -> max n res) 0 (compress lst)
--maxRepeated lst = maximum (map snd (compress lst))
maxRepeated lst = maximum [ n | (_,n)<-compress lst ]

-- Зад.9
makeSet lst = foldr (\ el res -> if el `elem` res then res else el:res) [] lst
-- За итеративно решение: foldl с разменени аргументи на ламбдата

-- Зад.10
histogram lst = [ (el,count el) | el<-makeSet lst ]
  where count el = length [ x | x<-lst, x==el ]

-- Зад.11: не е проблем да имаме еднакви генератори
maxDistance pts = maximum [ dist p1 p2 | p1<-pts, p2<-pts ]
  where dist (x1,y1) (x2,y2) = sqrt $ (x1-x2)^2 + (y1-y2)^2
