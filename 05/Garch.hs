module Garch 
    ( Garch11 (..)
    , MarketState
    , forecast
    , buildVolatilities
    )where

import qualified Data.Vector.Unboxed as U

-- Market state of last return and variance.
-- We don't use standard deviations as it is not used in the formulas.
data MarketState = MarketState Double Double

data Garch11 = Garch11 {
    vol     :: Double,
    gamma   :: Double,
    alpha   :: Double,
    beta    :: Double
} deriving (Show)

forecast :: Garch11 -> MarketState -> Double
forecast (Garch11 v g a b) (MarketState r s) = v*g + a*r*r + b*s

buildVolatilities :: Garch11 -> Double -> U.Vector Double -> U.Vector Double
buildVolatilities g s0 v = U.init $ U.scanl f s0 v
    where f s r = forecast g (MarketState r s)