module Main (factorial, parProduct, main) where

import Criterion.Main (defaultMain, bench, whnf)

factorial :: Integer -> Integer
factorial 0 = 1
factorial 1 = 1
factorial n = parProduct [1..n]

parProduct :: Num a => [a] -> a
parProduct [] = 1
parProduct [x] = x
parProduct xs = left*right
    where
        n = length xs `div` 2
        (leftL, rightL) = splitAt n xs
        left = parProduct leftL
        right = parProduct rightL

main :: IO ()
main = defaultMain [
        bench "factorial 100" $ whnf factorial 100
    ]