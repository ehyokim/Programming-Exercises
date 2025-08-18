module HW6 where 

-- Ex 2 
fibs2 :: [Integer]
fibs2 = 0 : 1 : zipWith (+) fibs2 fibs2B
fibs2B = 1 : zipWith (+) fibs2 fibs2B

-- Ex 3 
data Stream a = C a (Stream a)

streamToList :: Stream a -> [a]
streamToList (C a as) = a : streamToList as

instance Show a => Show (Stream a) where
    show :: Show a => Stream a -> String
    show  = show . take 20 . streamToList

-- Ex 4 
streamRepeat :: a -> Stream a
streamRepeat elem = C elem (streamRepeat elem)

streamMap :: (a -> b) -> Stream a -> Stream b 
streamMap f (C ael as) = C (f ael) (streamMap f as)  

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f seed = C seed (streamFromSeed f (f seed))

-- Ex 5 
nats :: Stream Integer
nats = streamFromSeed (+1) 1

-- ruler :: Stream Integer


interleaveStreams :: Stream a -> Stream a -> Stream a 
interleaveStreams (C ae as) (C be bs) = C ae $ C be $ interleaveStreams as bs