module Ex8 where
import Prelude
import Chapter8 hiding (putNtimes, sumInts)

returnSum :: IO Integer
returnSum =
    do  putStr "Input two integers\n"
        int1 <- getInt
        int2 <- getInt
        let sum = int1 + int2
        return (sum)

putNtimes :: Int -> String -> IO ()
putNtimes n str =
    do  
        let totalStr = concat [s ++ "\n" | s <- replicate n str ]
        (putStr . show) totalStr

sumInts :: [Integer] -> IO ()
sumInts inputList =
    do 
        val <- getInt
        if (val == 0)
            then (putStrLn . show . sum) inputList
        else 
            sumInts (val : inputList)