module Deque 
    ( Deque,
      emptyQ,
      isEmptyQ,
      addQBegin,
      addQEnd,
      remQBegin,
      remQEnd
    ) where


data Deque a = Deque [a] [a]
    deriving (Eq, Show)

emptyQ :: Deque a
emptyQ = Deque [] []

isEmptyQ :: Deque a -> Bool
isEmptyQ (Deque [] []) = True
isEmpty _ = False 

addQBegin :: Deque a -> a -> Deque a 
addQBegin (Deque beginL endL) elem = Deque (elem:beginL) endL

addQEnd :: Deque a -> a -> Deque a 
addQEnd (Deque beginL endL) elem = Deque beginL (elem:endL)

remQBegin :: Deque a -> (a, Deque a)
remQBegin (Deque [] []) = error "Queue empty."
remQBegin (Deque [] endL) = remQBegin (Deque (reverse endL) [])
remQBegin (Deque (x:xs) endL) = (x, Deque xs endL)

remQEnd :: Deque a -> (a, Deque a)
remQEnd (Deque [] []) = error "Queue empty."
remQEnd (Deque beginL []) = remQEnd (Deque [] (reverse beginL))
remQEnd (Deque beginL (y:ys)) = (y, Deque beginL ys)

examp1 :: Deque Integer
examp1 = Deque [1,2] [3,4]

examp2 :: Deque Integer
examp2 = addQBegin examp1 4

examp3 :: Deque Integer
examp3 = addQEnd examp2 6

examp4 = Deque [2,3] []
examp5 = Deque [] [4,5] 