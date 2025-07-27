module Ex14 where 
import Prelude hiding (Left, Right, Either)
import Chapter14_2

-- Representing an integer expression.

data Ops = Add | Sub | Mult | Div
                deriving (Show,Eq)  
data Expr = Lit Integer | Op Ops Expr Expr 
                deriving (Show,Eq)                

data NTree = NilT |
             Node Integer NTree NTree
                   deriving (Show,Eq,Read,Ord)
-- Example trees

treeEx1 = Node 10 NilT NilT
treeEx2 = Node 17 (Node 14 NilT NilT) (Node 20 NilT NilT)
treeEx3 = (Node 3 (Node 2 (Node 5 NilT NilT) NilT) NilT)

maxTree :: NTree -> Integer
maxTree NilT = 0
maxTree (Node n left right) = max n (max (maxTree left) (maxTree right))

collapse :: NTree -> [Integer]
collapse NilT = []
collapse (Node n left right) = collapse left ++ [n] ++ collapse right

sort :: NTree -> [Integer]
sort NilT = []
sort (Node n left right) = merge (ins n (sort left)) (sort right)
    where
        ins :: Integer -> [Integer] -> [Integer] 
        ins n [] = [n]
        ins n (x:xs) 
            | (n <= x)      = n : x : xs
            | otherwise    = x : ins n xs

        merge :: [Integer] -> [Integer] -> [Integer]
        merge [] rightList = rightList
        merge leftList [] = leftList
        merge (x:xs) (y:ys)
            | x > y      = y : merge (x:xs) ys
            | otherwise  = x : merge xs (y:ys)

        

-- Evaluating an expression.
eval :: Expr -> Integer
eval (Lit n)     = n
eval (Op Add e1 e2) = (eval e1) + (eval e2)
eval (Op Sub e1 e2) = (eval e1) - (eval e2)
eval (Op Mult e1 e2) = (eval e1) * (eval e2)
eval (Op Div e1 e2)
            | divisor /= 0 = (eval e1) `div` divisor
            | otherwise    = 0 
            where divisor = eval e2

-- Three examples from Expr.


expr1 = Lit 2
expr2 = (Op Add (Lit 2) (Lit 3))
expr3 = (Op Add (Op Sub (Lit 3) (Lit 1)) (Lit 3))  
expr4 = (Op Mult (Op Add (Op Sub (Lit 3) (Lit 1)) (Lit 3)) (Lit 5)) 

sizeExpr :: Expr -> Integer
sizeExpr (Lit n) = 0
sizeExpr (Op ops e1 e2) = 1 + sizeExpr e1 + sizeExpr e2