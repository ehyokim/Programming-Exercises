module PriorQ 
    ( PriorQ,
      emptyQ,
      isEmptyQ,
      addQ,
      remQ
    ) where

newtype PriorQ a = PriorQ [(Int, a)]
    deriving (Eq, Show)

emptyQ :: PriorQ a
emptyQ = PriorQ []

isEmptyQ :: PriorQ a -> Bool
isEmptyQ (PriorQ []) = True
isEmptyQ (PriorQ _) = False

addQ :: PriorQ a -> (Int,a) -> PriorQ a
addQ (PriorQ q) pair = PriorQ (pair:q)

remQ :: PriorQ a -> (a, PriorQ a)
remQ pq@(PriorQ []) = error "Empty Queue"
remQ pq@(PriorQ q) = remElemPriorQ pq maxPair
    where
        remElemPriorQ :: PriorQ a -> (Int, a) -> (a, PriorQ a)
        remElemPriorQ pq@(PriorQ []) _ = error "Element not found"
        remElemPriorQ (PriorQ ((fl,sl):ls)) (rank, elem)
            | (fl == rank) = (elem, PriorQ ls)
            | otherwise   = (found_elem, addQ mended_q (fl, sl))
                where (found_elem, mended_q) = remElemPriorQ (PriorQ ls) (rank, elem)
        maxPair = foldr1 (\(e,el) (a,al) -> if e >= a then (e,el) else (a,al)) q 

examp1 :: PriorQ Integer
examp1 = PriorQ [(1,2), (2,-1), (4,3), (0,1)]