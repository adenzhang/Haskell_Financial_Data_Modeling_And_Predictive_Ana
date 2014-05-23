module Main (factorial, parProduct, main) where

import Criterion.Main (defaultMain, bench, whnf)
import Control.Parallel.Strategies

factorial :: Integer -> Integer
factorial 0 = 1
factorial 1 = 1
factorial n = pproduct [1..n]

parFold :: Strategy a -> (a -> a -> a) -> a -> [a] -> a
parFold strat f = foldl (\ z x -> f z x `using` strat)

pproduct :: Num a => [a] -> a
pproduct = parFold r0 (*) 1

parProduct :: Num a => [a] -> a
parProduct [] = 1
parProduct [x] = x
parProduct xs = (right `using` rpar) * left
    where
        n = length xs `div` 2
        (leftL, rightL) = splitAt n xs
        left = product leftL
        right = product rightL

main :: IO ()
main = defaultMain [
        bench "factorial 100" $ whnf factorial 100
    ]