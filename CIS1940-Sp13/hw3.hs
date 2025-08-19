module HW3 where

skips :: [a] -> [[a]]
skips [] = []
skips il = let len = length il in
                [[ elem | (index,elem) <- zip [1 .. len] il, index `mod` n == 0] | n <- [1 .. len]]
    

localMaxima :: [Integer] -> [Integer]
localMaxima list 
    | length list < 3   = []
    | otherwise = [elem | (index, elem) <- zip [0 .. (length list - 1)] list, localMaxs !! index]
    where
        grLeft = False : greaterThanLeft list
        grRight = greaterThanRight list ++ [False] 
        localMaxs = zipWith (&&) grLeft grRight

greaterThanLeft :: [Integer] -> [Bool]
greaterThanLeft list 
    | length list < 2 = []
    | otherwise = let (x:y:xs) = list in 
                      (x < y) : greaterThanLeft (y:xs) 

greaterThanRight :: [Integer] -> [Bool]
greaterThanRight list 
    | length list < 2 = []
    | otherwise = let (x:y:xs) = list in 
                      (x > y) : greaterThanRight (y:xs)

histogram :: [Integer] -> String 
histogram ints = let freqchart = [[ if row > colfreq then ' ' else '*'  
                                    | col <- [0..9], let colfreq = freqlst !! col] 
                                    | row <- [maxFreq, maxFreq-1..1]] in 
                    unlines freqchart ++ "==========\n0123456789\n"
    where freqlst = countFreq ints
          maxFreq = maximum freqlst 

countFreq :: [Integer] -> [Integer]
countFreq = foldr (countInt 0) (replicate 10 0)
    where countInt idx i (x:xs)
            | i == idx = (x + 1) : xs
            | otherwise = x : countInt (idx+1) i xs 