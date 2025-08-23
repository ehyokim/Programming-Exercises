module Scrabble where
import Data.Char

newtype Score = Score Int
    deriving (Show, Eq, Ord, Num)

instance Semigroup Score where
    (<>) = (+)

instance Monoid Score where
    mempty = Score 0

scoreOne = ['a', 'e', 'i', 'l', 'n', 'o', 'r', 's', 't', 'u']
scoreTwo = ['d', 'g']
scoreThree = ['b','p','m','c']
scoreFour = ['f', 'h', 'v', 'y', 'w']
scoreFive = ['k']
scoreEight = ['j','x']
scoreTen = ['q', 'z']

score :: Char -> Score
score c
    | lc `elem` scoreOne   = Score 1
    | lc `elem` scoreTwo   = Score 2
    | lc `elem` scoreThree = Score 3
    | lc `elem` scoreFour  = Score 4
    | lc `elem` scoreFive  = Score 5
    | lc `elem` scoreEight = Score 8
    | lc `elem` scoreTen   = Score 10
    | otherwise            = Score 0
    where lc = toLower c

scoreString :: String -> Score
scoreString = foldr ((+) . score) (Score 0)