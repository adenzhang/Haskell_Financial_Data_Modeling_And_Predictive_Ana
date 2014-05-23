{-# LANGUAGE OverlappingInstances #-}
module Poisson
    ( module Likelihood
    , Aic (..)
    , Poisson (..)
    ) where

import Likelihood

class Likelihood m => Aic m where
    parameters :: m -> Double
    aic :: m -> [Double] -> Double
    aic theta xs = 2*(parameters theta) - 2 * loglikelihood theta xs

newtype Poisson = Poisson Double

sumAndLen :: [Double] -> (Double, Double)
sumAndLen xs = (fromIntegral $ length xs, sum xs)

instance Likelihood Poisson where
    likelihood (Poisson lambda) xs = (lambda ** n) * exp (lambda * t)
        where   (n, t) = sumAndLen xs

    loglikelihood (Poisson lambda) xs = n * (log lambda) - lambda * t
        where   (n, t) = sumAndLen xs

instance IidPdf Poisson where
    pdf (Poisson lambda) t = k * exp k
        where   k   =   lambda * t 

instance MLE Poisson where
    mle (Poisson _) xs  = Poisson lambda
        where   lambda  = n/t
                (n, t)  = sumAndLen xs

instance Aic Poisson where
    parameters (Poisson _)  = 1
 
