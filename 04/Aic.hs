module Aic where

import Poisson
import Data.List

bestModel :: Aic m => [m] -> [Double] -> (m, Double)
bestModel ms xs = minimumBy aicCompare $ map aicWithModel ms
    where   aicWithModel m = (m, aic m xs)
            aicCompare (_, a1) (_, a2) = compare a1 a2
