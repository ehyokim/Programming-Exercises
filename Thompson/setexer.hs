module SetExer where
import Set hiding (diff)

diff :: Ord a => Set a -> Set a -> Set a
diff (Set sa) (Set sb) = Set (diffSet sa sb)
 
diffSet :: Ord a => [a] -> [a] -> [a]
diffSet [] sb = []
diffSet sa [] = sa
diffSet (hsa: sa) (hsb : sb)
    | (hsa < hsb)   = hsa : diffSet sa (hsb:sb)
    | (hsa == hsb)  = diffSet sa sb
    | otherwise     = diffSet (hsa: sa) sb

symmDiff :: Ord a => Set a -> Set a -> Set a 
symmDiff sa sb = union (diff sb ins) (diff sa ins)
    where ins = inter sa sb


-- powerSet :: Ord a => Set a -> Set (Set a)

-- getSing :: Ord a => Set a -> [Set a]
-- getSing ()

setUnion :: Ord a => Set (Set a) -> Set a
setUnion = foldSet union empty 

setInter :: Ord a => Set (Set a) -> Set a
setInter superSet 
    | superSet == empty     = empty
    | otherwise             = foldSet (\s1 s2 -> inter s1 s2) totalSet superSet
        where totalSet = setUnion superSet


examp1 = Set [1,2,3,4]
examp2 = Set [3,4]
examp3 = Set [5]
examp4 = Set [4,5,7]

examp5 :: Set (Set Int)
examp5  = makeSet [examp1, examp4]

