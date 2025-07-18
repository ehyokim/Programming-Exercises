module Ex3 where
import Prelude
import Chapter3

threeDifferent :: Integer -> Integer -> Integer -> Bool
threeDifferent a b c = (a /= b) && (b /= c) && (a /= c)


fourEqual :: Integer -> Integer -> Integer -> Integer -> Bool
fourEqual a b c d = (threeEqual a b c) && (d == a) 

funny :: Integer -> Integer

funny x = x+x
    + x
  +2
peculiar y = y

