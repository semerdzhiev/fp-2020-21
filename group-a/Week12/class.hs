data Person =  Citizent{ name :: String
                       , age :: Int
                       }

             | Foreign{ name :: String
                      , idn :: String
                      , citizentOf :: String
                      }

             | JonDowe deriving(Show)

stringInfo :: Person -> String
stringInfo Citizent{name = name} = name
stringInfo person@Foreign{citizentOf = "Bulgaria"} = (name person) ++ " is not a foreign citizent"
stringInfo Foreign{name = name, citizentOf = country} = name ++ " from " ++ country
stringInfo JonDowe = "Unknown"

data Bool' = False' | True' deriving(Eq)

type String' = [Char]

type Name = String
type UCN = String
type Age = Int
type MeritalStatus = Bool


data Maybe' a = Just' a | Nothing'
-- data Result a b = Value a | Error b deriving(Show)

class Eq' a where
  (==.) :: a -> a -> Bool
  (/=.) :: a -> a -> Bool

  (==.) x y = not(x /=. y)
  (/=.) x y = not(x ==. y)

-- Eq, Ord, Show, Read, Bounded, Enum

data GardedInt = Min | Value Integer | Max deriving(Eq, Ord, Read, Show)

instance Bounded GardedInt where
  minBound = Min
  maxBound = Max

-- instance Ord GardedInt where
--   (<=) Min _ = True
--   (<=) _ Max = True
--   (<=) (Value a) (Value b) = a <= b
--   (<=) _ _  = False

-- instance Show GardedInt where
--   show Min = "Min"
--   show Max = "Max"
--   show (Value a) = show a

data DayOfTheWeek = Monday | Tusday | Wensday | Thursday | Friday | Satureday | Sunday deriving(Enum, Bounded)
