module Ex17 where
import Chapter17 hiding (fac)

subLists :: [a] -> [[a]]
subLists [] = [[]]
subLists (x:xs) = [(x:l) | l <- subl] ++ [l | l <- subl]
    where subl = subLists xs

subSequencesEq :: Eq a => [a] -> [[a]]
subSequencesEq [] = [[]]
subSequencesEq [x] = [[x],[]]
subSequencesEq (x:y:xs) = [[x]] ++ [x:l | l <- subseqs, l /= [], head l == y] ++ [l | l <- subseqs]
    where subseqs = subSequences (y:xs) 


subSequences :: [a] -> [[a]]
subSequences list = [[list !! i | i <- [n .. m]] | n <- [0 .. len], m <- [n+1 .. len]]
    where len = length list - 1

fibonacci = 0 : fib 1 1
fib :: Int -> Int -> [Int]
fib n m = n : fib m (n+m) 

fl1 = 0 : 1 : zipWith (+) fl1 fl2
fl2 = 1 : zipWith (+) fl1 fl2  

factorial = 1 : fac 1 1 
fac :: Int -> Int -> [Int]
fac n m = (n * m) : fac (n * m) (m + 1)  

runningSums :: [Int] -> [Int]
runningSums l = 0 : runningSumsAux l
    where
    runningSumsAux :: [Int] -> [Int]
    runningSumsAux [] = []
    runningSumsAux (x:xs) =  x : (zipWith (+) l (runningSumsAux xs))

-- factorial using scanl
facScan = scanl' (*) 1 [1 .. ]

-- infinite powers of two 
powersofTwo = scanl' (*) 1 twos
    where twos = 2 : twos
    
-- running sum of only positive list of numbers 
runningSumPos :: [Int] -> [Int]
runningSumPos list = scanl' f 0 filList
    where filList = [x | x <- list, x > 0]