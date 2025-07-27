module Ex14_2 where
import Prelude hiding (Left, Right, Either)
import Chapter14_2 hiding (either, edit)

twist :: Either a b -> Either b a 
twist (Left x) = Right x 
twist (Right y) = Left y

join :: (a->c) -> (b->d) -> Either a b -> Either c d
join f g (Left x) = Left (f x)
join f g (Right y) = Right (g y)

edit :: [Edit] -> String -> String
edit [] st = st
edit (e:es) [] 
    = case e of 
        Insert c -> c : edit es []
        Kill -> []
        _ -> edit es []

edit (e:es) (s:st) 
    = case e of
        Insert c -> c : edit es (s:st)
        Delete -> edit es st
        Change c -> c : edit es st 
        Copy -> s : edit es st
        Kill -> [] 

printSeqEdits :: [Edit] -> String -> [String]
printSeqEdits [] str = [str]
printSeqEdits es str = zipWith (\e s -> edit e s) (prefixSubList es) (replicate lenEdits str)
                where 
                    lenEdits = length es
                    prefixSubList :: [a] -> [[a]] 
                    prefixSubList (e:[]) = [[e]]
                    prefixSubList es = prefixSubList (init es) ++ [es] 

