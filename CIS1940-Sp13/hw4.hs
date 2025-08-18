module HW4 where

-- Ex 1
fun1' :: [Integer] -> Integer
fun1' =  foldr (\x s -> (x - 2) * s) 1 . filter even

fun2' :: Integer -> Integer
fun2' = sum . filter even . takeWhile (/= 0) . iterate collatz
        where collatz n
                | n == 1 = 0
                | even n = n `div` 2
                | otherwise = 3 * n + 1


-- Ex 2
data Tree a = Leaf | Node Integer (Tree a) a (Tree a)
                deriving (Show, Eq)

foldTree :: [a] -> Tree a 
foldTree = foldr insertTree Leaf

insertTree :: a -> Tree a -> Tree a 
insertTree val Leaf = Node 0 Leaf val Leaf
insertTree val (Node h t1 nodeval t2)
    | t1leaf && not t2leaf = Node h t1insert nodeval t2
    | not t1leaf && t2leaf = Node h t1 nodeval t2insert
    | t1leaf && t2leaf = Node (h+1) t1insert nodeval t2
    | otherwise = if t1height > t2height then 
                    Node (findHeight t1 t2insert + 1) t1 nodeval t2insert
                  else
                    Node (findHeight t1insert t2 + 1) t1insert nodeval t2
    where t1leaf = isLeaf t1
          t2leaf = isLeaf t2
          t1height = getHeight t1
          t2height = getHeight t2
          t1insert = insertTree val t1
          t2insert = insertTree val t2

          findHeight :: Tree a -> Tree a -> Integer
          findHeight (Node h1 _ _ _) (Node h2 _ _ _) = max h1 h2

-- Implement a basic print function for this tree.

isLeaf :: Tree a -> Bool
isLeaf Leaf = True
isLeaf _ = False 

getHeight :: Tree a -> Integer
getHeight (Node h _ _ _) = h 
getHeight _ = 0

-- Ex 3
xor :: [Bool] -> Bool 
xor = foldr (\t s -> (t && not s) || (not t && s))  False

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x s -> f x : s) []

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f base xs = foldr (flip f) base (reverse xs)

-- Ex 4