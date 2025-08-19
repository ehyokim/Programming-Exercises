module Calc  where
import ExprT
import Parser


-- Ex 1 
eval :: ExprT -> Integer
eval (Lit i) = i 
eval (Add expr1 expr2) = eval expr1 + eval expr2
eval (Mul expr1 expr2) = eval expr1 * eval expr2

-- Ex 2
evalStr :: String -> Maybe Integer
evalStr str = case parseExp Lit Add Mul str of
                Just exp -> Just $ eval exp
                _ -> Nothing 

-- Ex 3 
class Expr a where 
    lit :: Integer -> a
    mul :: a -> a -> a
    add :: a -> a -> a

instance Expr ExprT where
    lit = Lit
    mul = Mul
    add = Add

-- Ex 4
newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)

instance Expr Integer where
    lit = id 
    mul = (*)
    add = (+)

instance Expr Bool where
    lit = (> 0)
    mul = (&&)
    add = (||)

instance Expr MinMax where
    lit = MinMax 
    mul (MinMax x) (MinMax y) = MinMax $ min x y
    add (MinMax x) (MinMax y) = MinMax $ max x y

instance Expr Mod7 where
    lit = Mod7 . (`mod` 7)
    mul (Mod7 x) (Mod7 y) = Mod7 $ (x*y) `mod` 7
    add (Mod7 x) (Mod7 y) = Mod7 $ (x+y) `mod` 7

testExp :: Expr a => Maybe a
testExp = parseExp lit add mul "(3 * -4) + 5"

testInteger = testExp :: Maybe Integer
testBool = testExp :: Maybe Bool
testMM = testExp :: Maybe MinMax
testSat = testExp :: Maybe Mod7