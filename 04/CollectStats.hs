{-# LANGUAGE FlexibleContexts #-}
module CollectStats
    ( Stat(..)
    , collectStats
    ) where

import Statistics.Sample
import qualified Statistics.Sample.Histogram as H
import LegacyTable
import qualified Data.Vector.Unboxed as U
import qualified Data.Vector.Generic as G
import qualified Data.Map as M
import Data.Time.LocalTime (TimeOfDay (..), timeOfDayToTime)

data Stat = Stat {
        stMean     :: Double,
        stDev      :: Double,
        stMin      :: Double,
        stMax      :: Double,
        stHisto    :: M.Map Double Double 
    }
    deriving Show

mkTimeInt :: TimeOfDay -> Int
mkTimeInt = (*) 1000 . truncate . timeOfDayToTime

mkInt :: Tick -> Double
mkInt (Tick _ td ms _ _ _ _) = 
    fromIntegral $ (ms `div` 1000) + mkTimeInt td

durations :: Num a => [a] -> [a]
durations xs = map (\(a,b) -> b - a) tuples
    where
        tuples = zip xs (tail xs)

toMap :: (U.Vector Double, U.Vector Double) -> M.Map Double Double
toMap (a, b) = M.fromList $ G.toList $ G.zip a b

histogram :: Int -> Double -> Double -> U.Vector Double -> (U.Vector Double, U.Vector Double)
histogram numBins lo hi xs = (G.generate numBins step, H.histogram_ numBins lo hi xs)
    where 
        step i     = lo + d * fromIntegral i
        d          = (hi - lo) / fromIntegral numBins

collectStats :: [Tick] -> Stat
collectStats ticks = Stat m (sqrt v) mn mx (toMap hist)
    where
        msecs     = map mkInt ticks
        durs      = (U.fromList $ durations msecs) :: U.Vector Double
        (m, v)    = meanVariance durs
        mn        = U.minimum durs
        mx        = U.maximum durs
        hist      = histogram 100 0.0 mx durs
