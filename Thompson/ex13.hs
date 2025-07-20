module Ex13 where 
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

