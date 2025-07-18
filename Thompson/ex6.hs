module Ex6 where
import Prelude
import Pictures hiding (printPicture)

samplePic :: Picture
samplePic = [".##.", ".#.#", ".###", "####"]

printPicture :: Picture -> IO ()
printPicture pic = (putStr . const_str) pic
    where
        const_str :: Picture -> String 
        const_str [] = ""
        const_str pic = head pic ++ "\n" ++ const_str (tail pic)


rotate90 :: Picture -> Picture
rotate90 pic = rotatePic pic 0
        where
            maxIdx = length (head pic)
            rotatePic :: Picture -> Int -> Picture 
            rotatePic p n 
                | (n /= maxIdx) = [ row !! n | row <- (reverse p)] : rotatePic p (n+1)
                | otherwise     = []

type CompPic = [[(Int, Char)]]

compSamplePic :: CompPic
compSamplePic = [[(1,'.'), (2, '#'), (1, '.')], [(1,'.'), (1,'#'), (1,'.'), (1,'#')], [(1,'.'), (3,'#')], [(4,'#')]]

unzipPic :: CompPic -> Picture 
unzipPic pic = map unZipLine pic

unZipLine :: [(Int, Char)] -> String
unZipLine [] = []
unZipLine tups = replicate freq char ++ unZipLine (tail tups)
    where 
        (freq, char) = head tups

zipPic :: Picture -> CompPic
zipPic pic = map zipLine pic

zipLine :: String -> [(Int, Char)]
zipLine line = zipLineCount line (0, head line)

zipLineCount :: String -> (Int, Char) -> [(Int,Char)]
zipLineCount [] currChar = [currChar]
zipLineCount s (freq, char) 
    | bc == char = zipLineCount (tail s) (freq+1, char)
    | otherwise      = (freq, char) : zipLineCount (tail s) (1, bc) 
    where 
        bc = head s

type FlatPic = (Int, [(Int, Char)])

sampleFlatPic :: FlatPic
sampleFlatPic = (4, [(1,'.'), (2,'#'), (2,'.'), (1,'#'), (1,'.'), (1,'#'), (1 ,'.'), (7,'#')])

unzipFlatPic :: FlatPic -> Picture
unzipFlatPic (dim, flatList) = ((map concat) . accumRows) flatList  
    where
        accumRows :: [(Int, Char)] -> [[String]]
        accumRows flattenList
            | trimmedFlat == [] = [accum]
            | otherwise         = accum : accumRows trimmedFlat -- No Error checking done here.
            where 
                (trimmedFlat, accum) = unZipLoop dim flattenList
        unZipLoop :: Int -> [(Int,Char)] -> ([(Int, Char)], [[Char]]) 
        unZipLoop xCount flattenTup
            | xCount > freq =
                            let (tailFlatTup, accum) = unZipLoop (xCount - freq) (tail flattenTup) in
                                (tailFlatTup, replicate freq char : accum)
            | xCount == freq = ((tail flattenTup), [xCountDupStr])
            | xCount < freq = ((freq - xCount, char) : tail flattenTup, [xCountDupStr])
            where
                (freq, char) = head flattenTup
                xCountDupStr = replicate xCount char