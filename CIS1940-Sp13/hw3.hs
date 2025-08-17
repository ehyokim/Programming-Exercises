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
