module Ex7 where
import Prelude hiding (sum, head, tail)
import Chapter7

elemNum :: Integer -> [Integer] -> Integer
elemNum _ [] = 0
elemNum i (x:xs) 
    | i == x    = 1 + elemNum i xs
    | otherwise = elemNum i xs

elemNumNoRer :: Integer -> [Integer] -> Integer
elemNumNoRer i list = sum [1 | l <- list, i == l]

unique :: [Integer] -> [Integer]
unique list = findUnique list []
    where
        findUnique :: [Integer] -> [Integer] -> [Integer]
        findUnique [] _ = []
        findUnique (x:xs) seenList
            | x `elem` xs = findUnique xs (x : seenList)
            | not (x `elem` xs) && (x `elem` seenList) = findUnique xs seenList
            | otherwise = x : findUnique xs (x : seenList)

uniqueListComp :: [Integer] -> [Integer]
uniqueListComp list = [i | i <- list, elemNum i list == 1]

removeDup :: [Integer] -> [Integer]
removeDup [] = []
removeDup (x:xs) 
    | x `elem` xs   = removeDup xs
    | otherwise     = x : removeDup xs

isSubList :: String -> String -> Bool
isSubList [] _ = True
isSubList _ [] = False
isSubList (x:xs) (y:ys) 
    | (x == y)  = isSubList xs ys
    | otherwise = isSubList (x:xs) ys 

isSubSeq :: String -> String -> Bool
isSubSeq [] _ = True
isSubSeq _ [] = False
isSubSeq (x:xs) (y:ys)
    | (x == y) = case (isMatch xs ys) of
                    True -> True
                    False -> isSubSeq (x:xs) ys
    | otherwise = isSubSeq (x:xs) ys
    where
        isMatch :: String -> String -> Bool
        isMatch [] _ = True
        isMatch _ [] = False
        isMatch (x:xs) (y:ys) 
            | (x == y)  = isMatch xs ys
            | otherwise = False
        
isPalin :: String -> Bool
isPalin [] = True
isPalin [x] = True
isPalin str 
    | firstChar == lastChar = isPalin ((tail . init) str)
    | otherwise             = False
    where
        firstChar = head str
        lastChar = last str