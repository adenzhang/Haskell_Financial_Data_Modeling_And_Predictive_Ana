module Main where

import Control.Parallel.Strategies

square :: Integer -> Eval Integer
square x = return $ x * x

main :: IO ()
main = do
    let x = [1..1000000] :: [Integer]
    print $ sum $ parMap r0 (\z -> z*z) x
    return ()