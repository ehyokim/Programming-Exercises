module Ex10 where
import Prelude hiding (map, foldr, last, foldr1, init, and)
import Chapter10

sumOfSquares :: [Integer] -> Integer
sumOfSquares = (foldr (+) 0 . map (^2))

secArg :: a -> b -> b
secArg _ y = y

last :: [a] -> a
last = foldr1 secArg

init :: [a] -> a
 
filterFirst :: (a -> Bool) -> [a] -> [a]
filterFirst f (x:xs)
    | f x       = x : filterFirst f xs
    | otherwise = xs

filterLast :: (a -> Bool) ->[a] -> [a]
filterLast f list = removeLast list (map f list)
    where 
        removeLast :: [a] -> [Bool] -> [a]
        removeLast [] [] = []
        removeLast (x:xs) (y:ys) 
            | (not y) && (not (y `elem` ys)) = removeLast xs ys 
            | otherwise                      = x : removeLast xs ys


filterLastComp :: (a -> Bool) -> [a] -> [a]
filterLastComp f = reverse . (filterFirst f) . reverse

split :: [a] -> ([a], [a])
split [] = ([], [])
split [x] = ([x],[])
split (x:(y:ys)) =
            let (left,right) = split ys in
                (x:left , y:right)
