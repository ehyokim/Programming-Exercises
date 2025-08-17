module Hw1 where

toDigits :: Integer -> [Integer]
toDigits input 
    | input <= 0 = []
    | otherwise  = toDigits (input `div` 10) ++ [ input `mod` 10 ]

toDigitsRev :: Integer -> [Integer]
toDigitsRev input 
    | input <= 0 = []
    | otherwise  = (input `mod` 10) : toDigitsRev (input `div` 10)

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther il@[x] = il
doubleEveryOther il@(x:y:xs) = if even (length il) then  
                                  2 * x : y : doubleEveryOther xs
                               else
                                  x : 2 * y : doubleEveryOther xs  

sumDigits :: [Integer] -> Integer
sumDigits [] = 0 
sumDigits (x:xs) = (sum $ toDigits x) + sumDigits xs

validate :: Integer -> Bool
validate inputInt 
    | (sum `mod` 10) == 0 = True
    | otherwise = False
    where sum = sumDigits $ doubleEveryOther $ toDigits inputInt 

type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 1 a b _ = [(a,b)]
hanoi 2 a b c =  [(a,c), (a,b), (c,b)]
hanoi n a b c = hanoi (n-1) a c b ++ [(a,b)] ++ hanoi (n-1) c b a 