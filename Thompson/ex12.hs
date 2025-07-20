module Ex12 where
import Pictures
import Prelude hiding (succ)
import Chapter11 hiding (succ)
import Chapter12 hiding (printPicture)

isEven :: Int -> Bool
isEven = (== 0) . (`mod` 2)

invertChar :: Char -> Char 
invertChar ch 
    = if ch=='.' then '#' else '.'

chessBoard :: Int -> Picture 
chessBoard n
    | n <= 0 = [['#']]
    | otherwise = foldr getLine [] [0..(n-1)]
    where
        firstRow = foldr getColor [] [0..(n-1)]
        getColor x l  = (if isEven x then '#' else '.') : l
        getLine l b = (if isEven l then firstRow else map invertChar firstRow) : b


type FlattenedPic = (Int, Int, [(Int,Int)])

makePicture :: Int -> Int -> [(Int,Int)] -> Picture 
makePicture n m blackList
    | (n == 0) || (m == 0) = []
    | otherwise            = let popLine i pic = 
                                    if (rowHasBlack i) then
                                        fillBlackLine i : pic
                                    else replicate m '.' : pic 
                             in
                                foldr popLine [] [0 .. (n-1)]
                            where 
                                (rows, cols) = unzip blackList
                                rowHasBlack row = row `elem` rows
                                fillBlackLine i = let checkBlackPos y = (i,y) `elem` blackList in
                                                        foldr (\y l -> if checkBlackPos y then '#':l else '.':l) [] [0 .. (m-1)]

samplePic :: Picture
samplePic = ["....", ".##.","...."]

pictureToRep :: Picture -> FlattenedPic
pictureToRep pic =  let blackList = foldr popBlackList [] [0 .. (height-1)] in
                        (width, height, blackList)
        where 
            width = length $ head pic
            height = length pic
            popBlackList row l = (foldr (addBlackPos row) [] [0 .. (width-1)]) ++ l
            addBlackPos rowIdx colIdx bpl = if (((pic !! rowIdx) !! colIdx) == '#') then 
                                                (rowIdx,colIdx) : bpl
                                            else bpl


flatFlipV :: FlattenedPic -> FlattenedPic
flatFlipV (width, height, blackList) = 


succ :: Natural a -> Natural a 
succ n = (\f -> f . n f)

plus :: Natural a -> Natural a -> Natural a
plus n m = (\f -> n f . m f)

times :: Natural a -> Natural a -> Natural a
times n m = n . m