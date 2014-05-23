module LogGarch where

import Garch (Garch11, buildVolatilities)
import Data.Vector.Unboxed as U
import Statistics.Sample (mean)

log2pi :: Double
log2pi = log (2*pi)

logLikelihood :: U.Vector Double -> Double -> Garch11 -> Double
logLikelihood rs s0 g =
    let
        n                  = fromIntegral $ U.length rs
        mu                 = mean rs
        variances          = buildVolatilities g s0 rs
        sumOfVariance      = U.sum variances
        sumOfResidues      = U.foldl' (residue mu) 0.0 $ U.zip rs variances
        residue m a (r, s) = a + (r - m) ** 2 / s
    in
        - 0.5*(n*log2pi + sumOfVariance + sumOfResidues)
{-# INLINE logLikelihood #-}