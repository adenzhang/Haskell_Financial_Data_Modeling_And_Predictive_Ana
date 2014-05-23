{-# LANGUAGE FlexibleInstances, UndecidableInstances #-}
module Likelihood where

class Likelihood theta where
    likelihood :: theta -> [Double] -> Double
    loglikelihood :: theta -> [Double] -> Double
    loglikelihood theta xs = (log . likelihood theta) xs

class IidPdf theta where
    pdf :: theta -> Double -> Double

instance IidPdf m => Likelihood m where
    likelihood theta = product . map (pdf theta)
    loglikelihood theta = sum . map (log . pdf theta)

argmax :: Likelihood a => a-> (a -> Double) -> a
argmax start f = undefined

class (Likelihood theta, IidPdf theta) => MLE theta where
    mle :: theta -> [Double] -> theta 
    mle start xs = argmax start f
        where   f x = likelihood x xs

