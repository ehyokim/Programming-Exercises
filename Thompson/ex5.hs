module Ex5 where
import Chapter5
import Prelude hiding (elem)


divisors :: Integer -> [Integer]
divisors n = [x | x <- [1 .. n], n `mod` x == 0]

isPrime :: Integer -> Bool 
isPrime n = (checkLen . divisors) n
    where 
        checkLen :: [Integer] -> Bool
        checkLen [x,y] = True
        checkLen _ = False

matches :: Integer -> [Integer] -> [Integer]
matches x l = [y | y <- l, x == y]

elem :: Integer -> [Integer] -> Bool
elem x l = checkEmpty (matches x l)
    where 
        checkEmpty :: [Integer] -> Bool
        checkEmpty [] = False
        checkEmpty _ = True

pushRight :: String -> Integer -> String 
pushRight l x = reverse (pad x (reverse l)) 
    where
        pad :: Integer -> String -> String
        pad 0 t = []
        pad y (s:sx) = [s] ++ pad (y - 1) sx
        pad y [] = " " ++ pad (y - 1) []


blackSquares :: Integer -> Picture

blackSquares n
  | n<=1         = black
  | otherwise = black `beside` blackSquares (n-1)

vertWhiteSquares :: Integer -> Picture

vertWhiteSquares n
  | n<= 1   = white
  | otherwise = white `beside` vertWhiteSquares (n-1)

blackWhite :: Integer -> Picture

blackWhite n
  | n<=1         = black
  | otherwise = black `beside` whiteBlack (n-1)

vertBlackWhite :: Integer -> Picture 
vertBlackWhite n
  | n<=1         = black
  | otherwise = black `above` whiteBlack (n-1)

whiteBlack :: Integer -> Picture
whiteBlack n 
    | n <= 1    = white
    | otherwise = white `beside` blackWhite (n-1)

vertWhiteBlack :: Integer -> Picture
vertWhiteBlack n 
    | n <= 1    = white
    | otherwise = white `above` blackWhite (n-1)

blackChess :: Integer -> Integer -> Picture

blackChess n m
  | n<=1         = blackWhite m
  | otherwise = blackWhite m `above` whiteChess (n-1) m

whiteChess :: Integer -> Integer -> Picture
whiteChess n m 
  | n <= 1  = whiteBlack n
  | otherwise = whiteBlack m `above` blackChess (n-1) m

diagonal :: Integer -> Picture 

diagonal n 
  | n <= 1 = black
  | otherwise = (diagonal (n-1) `beside` vertWhiteSquares (n-1)) `above` base n
  where 
    base :: Integer -> Picture 
    base x
      | x <= 1 = black
      | otherwise = white `beside` base (x-1)
  
chessBoard :: Integer -> Picture
chessBoard n 
    | n <=1 = black 
    | otherwise = (chessBoard (n-1) `beside` vertStrip) `above` horString
    where
      even = isEven n 
      vertStrip = if even then vertWhiteBlack (n-1) else vertBlackWhite (n-1)
      horString = if even then whiteBlack n else blackWhite n 