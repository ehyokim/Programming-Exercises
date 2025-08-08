module Ex18 where
import Prelude hiding (repeat, sequence)

fmap :: (a -> b) -> IO a -> IO b 
fmap f ioa = do res <- ioa
                return (f res)

repeat :: IO Bool -> IO () -> IO ()
repeat ioflag ioop = do flag <- ioflag  
                        if flag then 
                            return ()
                        else 
                            repeat ioflag ioop 

accumulate :: [IO a] -> IO [a]
accumulate [] = do return ([]) 
accumulate (ioh : iolist) = do res <- ioh
                               rest <- accumulate iolist
                               return (res : rest)

sequence :: [IO a] -> IO ()
sequence [] = do return ()
sequence (ioh : iolist) = do ioh
                             sequence iolist

seqList :: [a -> IO a] -> a -> IO a 
seqList [] input = return (input)
seqList (f : funcList) input = do res <- f input
                                  res_tail <- seqList funcList res
                                  return (res_tail)