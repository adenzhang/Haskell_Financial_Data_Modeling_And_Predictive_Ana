module Estimators
    ( TimeSeries
    , Estimation (..)
    , Estimator (..)
    ) where

import BarOptimized

type TimeSeries = [Bar]

data Estimation = Estimation {-# UNPACK #-} !Double
    deriving (Show)

class Estimator algorithm where
    estimate :: algorithm -> TimeSeries -> Estimation