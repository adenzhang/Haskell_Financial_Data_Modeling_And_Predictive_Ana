module QuickTests where

import Test.QuickCheck
import Secant

acc :: Double
acc = 1e-8

acc2 :: Double
acc2 = 1e-4

squareF a b = \x -> a*x*x - b

propSquareSolve a b x0 = a > 0.0 && b >= 0.0 && x0 > 0.0 && x0 < b/a ==> isZero acc2 ((root acc (Secant (squareF a b) (0.0, x0))) ** 2 - (b/a))

main :: IO ()
main = do
	quickCheck propSquareSolve
	return ()