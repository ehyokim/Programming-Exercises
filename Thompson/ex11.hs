module Ex11 where
import Chapter11 hiding (succ)

total :: (Integer -> Integer) -> (Integer -> Integer)
total f = (\n -> sum $ (map f) $ [1..n])

flip :: (a -> b -> c) -> (b -> a -> c)
flip f = (\x y -> f y x)

iterList :: Int -> (a -> a) -> (a -> a) 
iterList n f 
    | n <= 1    = f
    | otherwise = (foldr1 (.)) $ replicate n f