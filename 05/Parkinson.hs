module Parkinson 
    ( Parkinson (..)
    )where

import BarOptimized
import Estimators
import Data.List (foldl')

data Parkinson = Parkinson

instance Estimator Parkinson where
    estimate Parkinson = Estimation . sqrt . divByN . foldl' summate (T 0.0 0)
        where
            divByN (T a n) = a / (4*log 2) / fromIntegral n
            summate (T a n) (Bar _ _ _ l h _) = T (a + logBase l h ** 2) (n + 1)

data T = T {-# UNPACK #-} !Double {-# UNPACK #-} !Int