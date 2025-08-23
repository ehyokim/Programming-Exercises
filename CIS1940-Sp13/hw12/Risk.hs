{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Risk where

import Control.Monad.Random
import Data.List (sortBy, partition)

------------------------------------------------------------
-- Die values

newtype DieValue = DV { unDV :: Int } 
  deriving (Eq, Ord, Show, Num)

first :: (a -> b) -> (a, c) -> (b, c)
first f (a, c) = (f a, c)

instance Random DieValue where
  random           = first DV . randomR (1,6)
  randomR (low,hi) = first DV . randomR (max 1 (unDV low), min 6 (unDV hi))

die :: Rand StdGen DieValue
die = getRandom

------------------------------------------------------------
-- Risk

type Army = Int

data Battlefield = Battlefield { attackers :: Army, defenders :: Army }

battle :: Battlefield -> Rand StdGen Battlefield
battle (Battlefield { attackers = atks, defenders = dfds }) = replicateM numAttackers die >>= 
            \arolls -> replicateM numDefenders die >>=
            \brolls -> 
              let (deadatks, deaddfds) = partition (<=0) $ zipWith (-) (sortd arolls) (sortd brolls)
              in
                return Battlefield { attackers = atks - length deadatks, defenders = dfds - length deaddfds}
  where getNumAttackers units
          | units > 3 = 3 
          | (units == 2) || (units == 3) = units - 1
        getNumDefenders units = min units 2 

        numAttackers = getNumAttackers atks
        numDefenders = getNumDefenders dfds

        sortd = sortBy (flip compare)

samplebf :: Battlefield
samplebf = Battlefield { attackers = 5, defenders = 3 }

invade :: Battlefield -> Rand StdGen Battlefield
invade bf@(Battlefield { attackers = atks, defenders = dfds })
        | (atks <= 1) || (dfds == 0) = return bf 
        | otherwise = battle bf >>= invade

successProb :: Battlefield -> Rand StdGen Double
successProb bf = sequence [invade bf | _ <- [1..1000]] >>= 
                 \bflist -> let atkwins = length $ filter ((==0) . defenders) bflist in
                              return (fromIntegral atkwins / 1000)

