module Grubbs (
      grubbs
    ) where

import qualified Data.Vector.Unboxed as U
import Statistics.Sample

grubbs :: [Double] -> Maybe Double
grubbs xs            
    | numOfOutliers > 0 = Just $ fst $ U.maximumBy cmpByG outliers
    | otherwise         = Nothing
    where   n                       = fromIntegral $ length xs
            gCritical               = (n-1)/(sqrt n)
            v                       = U.fromList xs 
            (m,s)                   = meanVarianceUnb v
            stddev                  = sqrt s
            getGtuple   x           = (x, (abs (x - m))/stddev)
            isOutlier (_, g)        = g > gCritical 
            outliers                = U.filter isOutlier $ U.map getGtuple v
            numOfOutliers           = U.length outliers
            cmpByG (_, a) (_, b)    = compare a b
