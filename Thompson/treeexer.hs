module TreeExer where
import Tree

successor :: Ord a => a -> Tree a -> Maybe a 
successor _ Nil = Nothing
successor v (Node n t1 t2)
    | (n <= v)                 = if (isNil t2) then Nothing else successor v t2
    | (v < n)  && (isNil t1)   = Just n 
    | (v < n)  && (v <= v1)    = successor v t1
    | (v < n)  && (v > v1)     = Just n 
    where
        v2 = treeVal t2
        v1 = treeVal t1

sampTree :: Tree Int
sampTree = (insTree 5 . insTree 15 . insTree (-1) . insTree 3 . insTree 10 . insTree (-5)) Nil

closest :: Int -> Tree Int -> Int 
closest v t = snd $ findClosestDis v t
    where 
        findClosestDis :: Int -> Tree Int -> (Int, Int)
        findClosestDis arg (Node val lt rt) = 
                    foldr1 (\(a1,a2) (b1,b2) -> if a1 < b1 then (a1,a2) else (b1,b2)) 
                           ([(abs(arg-val), val)] ++ leftRes ++ rightRes)
            where
                leftRes = if (isNil lt) then [] else [findClosestDis arg lt]
                rightRes = if (isNil rt) then [] else [findClosestDis arg rt]