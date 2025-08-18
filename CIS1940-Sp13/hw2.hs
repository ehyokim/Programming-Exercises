{-# OPTIONS_GHC -Wall #-}
module HW2 where
import Log
import Data.Char

-- Ex 1 

parse :: String -> [LogMessage]
parse = map parseMessage . lines 

parseMessage :: String -> LogMessage 
parseMessage message = case (msgType, timeStamp) of
                        (Nothing, _) -> Unknown message
                        (_, Nothing) -> Unknown message
                        (Just mtype, Just tstamp) -> LogMessage mtype tstamp $ unwords $ drop (findMessageTxt mtype) wordList  
    where wordList = words message
          msgType = parseMessageType wordList
          timeStamp = parseTimeStamp wordList


parseMessageType :: [String] -> Maybe MessageType
parseMessageType wordsList
    | length wordsList < 3 = Nothing
    | otherwise = let (x:y:xs) = wordsList in
                        case x of
                            "I" -> Just Info
                            "W" -> Just Warning
                            "E" -> if isNumeric y then
                                        Just (Error (read y :: Int))
                                    else 
                                        Nothing       
                            _ -> Nothing

parseTimeStamp :: [String] -> Maybe Int
parseTimeStamp wordsList
    | length wordsList < 3 = Nothing
    | otherwise = let (x:y:xs) = wordsList in
                        case x of
                            "I" -> checkTimeStamp 1
                            "W" -> checkTimeStamp 1 
                            "E" -> checkTimeStamp 2
                            _ -> Nothing
    where 
        checkTimeStamp idx = let tsstr = wordsList !! idx in
                                if isNumeric tsstr then
                                    Just (read tsstr :: Int)
                                else
                                    Nothing 

findMessageTxt :: MessageType -> Int
findMessageTxt (Error _) = 3 
findMessageTxt _ = 2 

isNumeric :: String -> Bool
isNumeric = foldr (\x s -> isDigit x && s) True  


-- Ex 2 

insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) t = t
insert msg Leaf = Node Leaf msg Leaf
insert msg@(LogMessage _ ts _ ) (Node left nodemsg right) 
    | ts < nodets = Node (insert msg left) nodemsg right
    | otherwise   = Node left nodemsg (insert msg right)
    where nodets = getTimeStamp nodemsg 

getTimeStamp :: LogMessage -> Int
getTimeStamp (LogMessage _ ts _) = ts
getTimeStamp _ = 0 

getText :: LogMessage -> String
getText (LogMessage _ _ txt) = txt
getText (Unknown txt) = txt

-- Ex 3

build :: [LogMessage] -> MessageTree 
build = foldl (flip insert) Leaf 

-- Ex 4 

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node left nodemsg right) = inOrder left ++ [nodemsg] ++ inOrder right

-- Ex 5 

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong =  map getText . filter filterSevereError . inOrder . build
    where
        filterSevereError (LogMessage (Error severity) _ _) = severity >= 50
        filterSevereError _ = False
