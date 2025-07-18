module Ex4 where
import Ex3
import Chapter3
import Chapter4 hiding (maxThree)
import PicturesSVG

howManyEqual :: Integer -> Integer -> Integer -> Integer
howManyEqual a b c
    | threeEqual a b c     = 3
    | threeDifferent a b c = 0
    | otherwise            = 2

howManyofFourEqual :: Integer -> Integer -> Integer -> Integer -> Integer
howManyofFourEqual a b c d 
    | fourEqual a b c d                 = 4
    | threeDifferent a b c &&
        (d /= a) &&
        (d /= b) &&
        (d /= c)                        = 0
    | (threeEqual a b c && (d /= a)) ||
      (threeEqual a b d) && (c /= a) ||
      (threeEqual a c d) && (b /= a) ||
      (threeEqual b c d) && (a /= b)    = 3        
    | otherwise                         = 2


maxThreeOccurs :: Integer -> Integer -> Integer -> (Integer, Integer)
maxThreeOccurs a b c 
    | (maxNum == a) = tup a 
    | (maxNum == b) = tup b
    | (maxNum == c) = tup c 
    where 
        maxNum = maxThree a b c
        howManyTimes :: Integer -> Integer -> Integer -> Integer -> Integer
        howManyTimes num a b c 
            | threeEqual a b c              = 3
            | (threeDifferent a b c) ||
              ((a == c) && (num /= a)) ||
              ((a == b) && (num /= a)) ||
              ((b == c) && (num /= b))      = 1

            | ((a == c) && (num == a)) ||
              ((a == b) && (num == a)) ||
              ((b == c) && (num == b))      = 2
        tup x = (x , howManyTimes x a b c)


data Result = Win | Lose | Draw
              deriving (Show)

outcome :: Move -> Move -> Result
outcome p1 p2 
    | beat p1 == p2 = Lose
    | lose p1 == p2 = Win
    | otherwise     = Draw 

checkZero :: (Integer -> Integer) -> Integer -> Bool
checkZero f n
    | n < 0     = False
    | f n == 0  = True
    | otherwise = checkZero f (n-1)

