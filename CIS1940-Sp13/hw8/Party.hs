module Party where
import Employee
import Data.Tree
import Data.List 

-- Ex 1 

glCons :: Employee -> GuestList -> GuestList
glCons emp (GL guestlst totalfun) = GL (guestlst ++ [emp]) (totalfun + empFun emp)

moreFun :: GuestList -> GuestList -> GuestList
moreFun gl1@(GL _ gl1funscore) gl2@(GL _ gl2funscore)
    | gl1funscore > gl2funscore = gl1
    | otherwise = gl2

-- Ex 2 

treeFold :: (a -> [b] -> b) -> Tree a -> b 
treeFold f (Node {rootLabel = rl, subForest = sf}) = f rl (map (treeFold f) sf) 

-- Ex 3 

joinGL :: [GuestList] -> GuestList
joinGL = foldr1 joinGLPair
    where joinGLPair (GL guestlst1 totalfun1) (GL guestlst2 totalfun2) 
                        = GL (guestlst1 ++ guestlst2) (totalfun1 + totalfun2)

nextLevel :: Employee -> [(GuestList, GuestList)]
    -> (GuestList, GuestList)
nextLevel emp [] = (GL [emp] (empFun emp), GL [] 0) 
nextLevel boss subTreeGL = (withBossGL, woBossGL)
    where withBossGL = glCons boss (joinGL . map snd $ subTreeGL)
          woBossGL = joinGL . map (uncurry moreFun) $ subTreeGL 

-- Ex 4 

maxFunTup :: Tree Employee -> (GuestList, GuestList)
maxFunTup = treeFold nextLevel

maxFunTupScore :: Tree Employee -> (Integer, Integer)
maxFunTupScore tree = let (wb, wob) = maxFunTup tree in
                        (getGLFunScore wb, getGLFunScore wob)

getGLFunScore :: GuestList -> Integer
getGLFunScore (GL _ score) = score

getGLEmpList :: GuestList -> [Employee]
getGLEmpList (GL emplst _) = emplst

maxFun :: Tree Employee -> GuestList
maxFun = uncurry moreFun . maxFunTup

 -- Ex 5

main :: IO ()
main = do filecontents <- readFile "./company.txt"
          let comptree = read filecontents :: Tree Employee
          let compGL = foldTree compTreetoGL comptree
          let compGLFunScore = getGLFunScore compGL
          let sortedGLEmpList = sortOn firstName $ getGLEmpList compGL -- I haven't really taken the time to find a better solution than just sorting in place. 
          putStrLn $ "Total fun: " ++ show compGLFunScore
          putStr $ empListToStr sortedGLEmpList

firstName :: Employee -> String
firstName = head . words . empName

empListToStr :: [Employee] -> String
empListToStr = unlines . map empName 

compTreetoGL :: Employee -> [GuestList] -> GuestList
compTreetoGL emp [] = GL [emp] (empFun emp)
compTreetoGL boss subtreeGL = glCons boss (joinGL subtreeGL)