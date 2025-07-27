module Ex13 where
import Prelude hiding (uncurry, curry)
import Chapter13

-- instance Show (Bool -> Bool) where 
--    show f = "Input True: " ++ (show $ f True) ++ "\n" ++ "Input False: " ++ (show $ f False) 

func :: Bool -> Bool
func True = False
func False = True

func2 :: Int -> Int 
func2 = (+1)

instance (Info a, Show a) => Show (a->a) where 
    show f = foldr (\samp l -> "On input " ++ (show samp) ++ ": " ++ (show $ f samp) ++ "\n" ++ l) [] examples -- note that we "inherit" examples from the context Info a
 
 -- f n = 37 + n
-- f True = 34

--h x
--    | x > 0 = True
--    | otherwise = 37

hi :: (Int,b)
hi = hi
hello :: (Int, a)
hello = hello

curry :: ((a,b) -> c) -> (a -> b -> c)
curry g x y = g (x,y)

uncurry :: (a -> b -> c) -> ((a,b) -> c)
uncurry f (x,y) = f x y 

