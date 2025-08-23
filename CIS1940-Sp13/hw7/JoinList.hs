module JoinList where 
import Buffer
import Sized
import Scrabble

data JoinList m a = Empty
                | Single m a
                | Append m (JoinList m a) (JoinList m a)
    deriving (Eq, Show)

-- Ex 1 

(+++) :: Monoid m => JoinList m a -> JoinList m a -> JoinList m a
(+++) jl1 Empty = jl1
(+++) Empty jl2 = jl2
(+++) jl1 jl2 = let m1 = tag jl1 
                    m2 = tag jl2 in
                    Append (mappend m1 m2) jl1 jl2


tag :: Monoid m => JoinList m a -> m 
tag (Single mo _) = mo
tag (Append mo _ _) = mo 
tag Empty = mempty

-- Ex 2 

indexJ :: (Sized b, Monoid b) => 
        Int -> JoinList b a -> Maybe a 
indexJ _ Empty = Nothing
indexJ idx (Single _ elem) = Just elem
indexJ idx (Append _ leftjl rightjl)
                | (idx + 1) > leftsize + rightsize = Nothing
                | idx < 0                          = Nothing
                | (idx + 1) <= leftsize            = indexJ idx leftjl
                | otherwise                        = indexJ (idx - leftsize) rightjl  
    where leftsize = getSize . size . tag $ leftjl
          rightsize = getSize . size . tag $ rightjl

dropJ :: (Sized b, Monoid b) => 
    Int -> JoinList b a -> JoinList b a
dropJ _ Empty = Empty
dropJ n jl@(Single _ _)
    | n == 0    = jl
    | otherwise = Empty
dropJ n jl@(Append _ leftjl rightjl) 
    | n == 0         = jl
    | n >= leftsize  = dropJ (n - leftsize) rightjl
    | otherwise      = Append (droppedLeftSize <> rightsizeM) droppedLeftJL rightjl 
    where leftsize = getSize . size . tag $ leftjl
          rightsize = getSize . size . tag $ rightjl

          rightsizeM = tag rightjl

          droppedLeftJL = dropJ n leftjl
          droppedLeftSize = tag droppedLeftJL

takeJ :: (Sized b, Monoid b) =>
    Int -> JoinList b a -> JoinList b a
takeJ _ Empty = Empty
takeJ n jl@(Single _ _)
    | n == 0     = Empty 
    | otherwise  = jl
takeJ n jl@(Append _ leftjl rightjl)
    | n == 0         = Empty
    | n >= leftsize  = Append (leftsizeM <> takenRightSize) leftjl takenRightJL
    | otherwise      = takeJ n leftjl
    where leftsize  = getSize . size $ leftsizeM
          rightsize = getSize . size . tag $ rightjl

          leftsizeM = tag leftjl

          takenRightJL = takeJ (n - leftsize) rightjl
          takenRightSize = tag takenRightJL


buildSizeTreeJL :: [a] -> JoinList Size a
buildTreeJL [] = Empty 
buildTreeJL [x] = Single (Size 1) x 
buildTreeJL str = let (fh, sh) = splitAt (length str `div` 2) str 
                  in 
                    buildTreeJL fh +++ buildTreeJL sh

sampleJL :: JoinList Size Char
sampleJL = buildSizeTreeJL "Hello, World!"

jlToList :: JoinList m a -> [a]
jlToList Empty = []
jlToList (Single _ a) = [a]
jlToList (Append _ l1 l2) = jlToList l1 ++ jlToList l2

scoreLine :: String -> JoinList Score String
scoreLine str = Single (scoreString str) str

-- Ex 4 

buildScoreSizeTreeJL :: [String] -> JoinList (Score, Size) String
buildScoreSizeTreeJL [] = Empty 
buildScoreSizeTreeJL [x] = strToSingle x
buildScoreSizeTreeJL str = let (fh, sh) = splitAt (length str `div` 2) str 
                  in 
                    buildScoreSizeTreeJL fh +++ buildScoreSizeTreeJL sh

strToSingle :: String -> JoinList (Score, Size) String
strToSingle str = Single (scoreString str, Size 1) str 

instance Sized Score where
    size (Score i) = Size i

instance Buffer JoinList (Score, Size) String where
  -- | Convert a buffer to a String.
  toString = lines . jltoList

  -- | Create a buffer from a String.
  fromString = buildScoreSizeTreeJL . lines 

  -- | Extract the nth line (0-indexed) from a buffer.  Return Nothing
  -- for out-of-bounds indices.
  line = indexJ 

  -- | @replaceLine n ln buf@ returns a modified version of @buf@,
  --   with the @n@th line replaced by @ln@.  If the index is
  --   out-of-bounds, the buffer should be returned unmodified.
  replaceLine n str buf = take n buf +++ strToSingle str +++ drop (n+1) buf

  -- | Compute the number of lines in the buffer.
  numLines = getSize . snd . tag 

  -- | Compute the value of the buffer, i.e. the amount someone would
  --   be paid for publishing the contents of the buffer.
  value = getSize . size . fst . tag

