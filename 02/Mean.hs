{-# LANGUAGE FlexibleContexts #-}
module Main where

import qualified Data.Vector.Generic as G
import qualified Data.Vector.Unboxed as U

data T = T {-# UNPACK #-}!Double {-# UNPACK #-}!Int

-- | /O(n)/ Arithmetic mean.  This uses Welford's algorithm to provide
-- -- numerical stability, using a single pass over the sample data.
mean :: (G.Vector v Double) => v Double -> Double
mean = fini . G.foldl' go (T 0 0)
   where
       fini (T a _) = a
       go (T m n) x = T m' n'
              where m' = m + (x - m) / fromIntegral n'
                    n' = n + 1

genF :: Int -> Double
genF x  = fromIntegral x

main :: IO ()
main    = do
    let x = U.generate 100000001 genF
    let m = mean x
    putStrLn $ show m
