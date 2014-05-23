module Simple 
    ( toLogArray
    ) where

import Estimators
import BarOptimized
import Statistics.Sample (stdDev)
import qualified Data.Vector.Unboxed as U

data Simple = 
    SimpleWithMean
    | Simple

-- we assume that the array is already sorted by time stamp
toLogArray :: TimeSeries -> U.Vector Double
toLogArray bar = U.fromList $ zipWith delog bar (tail bar)
    where
        delog x0 x1 = log (bClose x1/bClose x0)

instance Estimator Simple where
    estimate SimpleWithMean = Estimation . stdDev . toLogArray
    estimate Simple = Estimation . sqrt . divByN . U.foldl' accum (0.0, 0) . toLogArray
        where
            accum (a, n) b = (a + b*b, n + 1)
            divByN (a, n)  = a / n