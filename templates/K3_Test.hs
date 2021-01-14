{--
  СУ "Св. Климент Охридски"
  Факултет по математика и информатика
  Курс Функционално програмиране 2020/21
  Контролно 3
  2021-01-16

  Име:
  ФН:
  Специалност:
  Курс:
  Административна група:
  Начален час на контролното: <тук попълнете часа за вашата група>
--}

-- Променете името на модула и на файла така, че да съответстват на
-- факултетния ви номер. Например ако той е 12345, променете ги
-- съответно на K3_12345_Test и K3_12345_Test.hs
-- (Можете да изтриете този коментар след като направите промените)
module K3_Test where

import Test.HUnit
import K3   -- Променете името на модула, който се включва така,
            -- че тук да се зарежда модулът с вашето решение.
            -- Например ако модулът с решението ви се казва K3_12345,
            -- променете реда на import K3_12345
            -- (Можете да изтриете този коментар след като направите промените)

-- Даденият по-долу пример е само ориентировъчен.
-- Когато решавате задачите си, можете да го изтриете
-- или да го промените така, че да проверява условия
-- свързани с вашия код.

-- Може да използвате пълния синтаксис...
test1 = TestCase $ assertEqual "sample check" 1 (sample 1)
test2 = TestCase $ assertBool  "sample check" (sample True)

-- ...или съкратената форма
test3 = "sample label" ~: 1 ~=? sample 1
test4 = "sample label" ~: sample 1 ~?= 1
test5 = "sample label" ~: sample True ~? "sample check"

-- Пример за няколкo проверки в един TestCase (пълна и съкратена форма)
test6 = TestCase $ do
  assertBool  "sample check" (sample True)
  assertEqual "sample check" 1 (sample 1)

test7 = TestCase $ do
  1 @=? sample 1
  sample 1 @?= 1
  sample True @? "sample check"

tl1 = TestList [test1,test2,test3,test4,
                test5,test6,test7]

-- Може да опишете тестовете и директно в списък
tl2 = TestList [

  "sample label" ~:
    1 ~=? sample 1,

  "sample label" ~:
    sample 1 ~?= 1,

  "sample label" ~:
    sample True ~? "sample check"

  ]

main = do
  runTestTT tl1
  runTestTT tl2
