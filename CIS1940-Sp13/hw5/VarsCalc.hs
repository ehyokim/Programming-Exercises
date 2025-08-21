{-# LANGUAGE FlexibleInstances #-}
module VarsCalc where
import qualified Data.Map as M
import Calc 

data VarExprT = Lit Integer
        | Add VarExprT VarExprT
        | Mul VarExprT VarExprT
        | Var String
    deriving (Show, Eq)

class HasVars a where
    var :: String -> a 

instance Expr VarExprT where 
    lit = Lit
    add = Add
    mul = Mul

instance HasVars VarExprT where
    var = Var 

type VarQuery = M.Map String Integer -> Maybe Integer

instance HasVars VarQuery where 
    var = M.lookup

instance Expr VarQuery where
    lit i = Just . const i
    add = queryAndOperate (+)
    mul = queryAndOperate (*)

queryAndOperate :: (Integer -> Integer -> Integer) 
    -> VarQuery -> VarQuery -> VarQuery
queryAndOperate op f1 f2 map = let f1Query = f1 map
                                   f2Query = f2 map
                               in
                                   case (f1Query, f2Query) of
                                        (Nothing, _) -> Nothing
                                        (_, Nothing) -> Nothing 
                                        (Just res1, Just res2) -> Just $ op res1 res2

withVars :: [(String, Integer)]
    -> (M.Map String Integer -> Maybe Integer)
    -> Maybe Integer
withVars vs exp = exp $ M.fromList vs
-- Note that simply applying the map object here works as by the instance declaration above, 
-- the (mul, add, lit) methods of class Expr will all output maps of type VarQuery