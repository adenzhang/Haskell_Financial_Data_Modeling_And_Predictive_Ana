module Rogers where

import BarOptimized
import Estimators
import Data.List (foldl')

data Rogers = Rogers

instance Estimator Rogers where
    estimate Rogers = Estimation . sqrt . combine . foldl' point (T 0.0 0)
        where
            combine (T a n) = a / fromIntegral n
            point (T a n) (Bar _ _ o h l c) = 
                T (a + logBase c h * logBase o h + logBase c l * logBase o l) (n + 1)

data T = T {-# UNPACK #-} !Double {-# UNPACK #-} !Int