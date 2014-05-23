module GarmanKlass where

import BarOptimized
import Estimators
import Data.List (foldl')

data GarmanKlass = GarmanKlass

instance Estimator GarmanKlass where
    estimate GarmanKlass = Estimation . sqrt . combine . foldl' point (TT 0.0 0.0 0)
        where
            logConst = 2.0 * log 2.0 - 1.0
            combine (TT a b n) = (0.5*a - logConst*b) / fromIntegral n
            point (TT a b n) (Bar _ _ o l h c) = TT (a + logBase l h ** 2) (b + logBase o c ** 2) (n + 1)

data TT = TT {-# UNPACK #-} !Double {-# UNPACK #-} !Double {-# UNPACK #-} !Int