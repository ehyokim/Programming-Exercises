module Ex12 where
import Prelude hiding (succ)
import Chapter11 hiding (succ)
import Chapter12


succ :: Natural a -> Natural a 
succ n = (\f -> f . n f)

plus :: Natural a -> Natural a -> Natural a
plus n m = (\f -> n f . m f)

times :: Natural a -> Natural a -> Natural a
times n m = n . m