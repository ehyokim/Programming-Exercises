module JoinList where 
import Sized

data JoinList m a = Empty
                | Single m a
                | Append m (JoinList m a) (JoinList m a)
    deriving (Eq, Show)

-- Ex 1 

(+++) :: Monoid m => JoinList m a -> JoinList m a -> JoinList m a
(+++) jl1 Empty = jl1
(+++) Empty jl2 = jl2
(+++) jl1 jl2 = let m1 = tag jl1 
                    m2 = tag jl2 in
                    Append (mappend m1 m2) jl1 jl2


tag :: Monoid m => JoinList m a -> m 
tag (Single mo _) = mo
tag (Append mo _ _) = mo
tag Empty = mempty  

-- Ex 2 

indexJ :: (Sized b, Monoid b) => 
        Int -> JoinList b a -> Maybe a 
indexJ _ Empty = Nothing
indexJ idx (Single _ elem) = Just elem
indexJ idx (Append _ leftjl rightjl)
                | (idx + 1) > leftsize + rightsize = Nothing
                | idx < 0 = Nothing
                | (idx + 1) <= leftsize = indexJ idx leftjl
                | otherwise = indexJ (idx - leftsize) rightjl  
    where leftsize = getSize . size . tag $ leftjl
          rightsize = getSize . size . tag $ rightjl

dropJ :: (Sized b, Monoid b) => 
    Int -> JoinList b a -> JoinList b a
dropJ _ Empty = Empty
dropJ n jl@(Single _ _)
    | n == 0 = jl
    | otherwise = Empty
dropJ n jl@(Append _ leftjl rightjl) 
    | n == 0 = jl
    | n >= leftsize = dropJ (n - leftsize) rightjl
    | otherwise = Append droppedLeftSize droppedLeftJl rightjl 
    where leftsize = getSize . size . tag $ leftjl
          rightsize = getSize . size . tag $ rightjl
          droppedLeftJl = dropJ n leftjl
          droppedLeftSize = tag droppedLeftJl


takeJ :: (Sized b, Monoid b) =>
    Int -> JoinList b a -> JoinList b a

takeJ _ Empty = Empty
takeJ n jl@(Single _ _)
    | n == 0 = Empty 
    | otherwise = jl
takeJ n jl@(Append _ leftjl rightjl)
    | n == 0 = Empty
    | n >= leftsize = Append (leftsized <> takenRightSize) leftjl takenRightJl
    | otherwise = takeJ n leftjl
    where leftsized = tag leftjl
          leftsize = getSize . size $ leftsized
          rightsize = getSize . size . tag $ rightjl
          takenRightJl = takeJ (n - leftsize) rightjl
          takenRightSize = tag takenRightJl

          