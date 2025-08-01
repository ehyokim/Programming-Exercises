module GraphExer where
import Set 
import Relation

distance :: Ord a => Relation a -> a -> a -> Int
distance graph source dest = if res >= numNodes then 0 else res
    where res = findDis graph source dest []
          numNodes = card graph 
          findDis :: Ord a => Relation a -> a -> a -> [a] -> Int 
          findDis gr so de found
                | so == de  = 0
                | otherwise = if isEmpty nbrs then numNodes else 
                                1 + foldr1 min (map (\n -> findDis gr n de found') nbrs)
                where 
                    found' = so : found
                    nbrs = findDescs gr found' so
                    
 
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _ = False

exampGraph :: Relation Int 
exampGraph = Set [(1,2), (1,3), (3,2), (3,4), (4,2), (2,4)]