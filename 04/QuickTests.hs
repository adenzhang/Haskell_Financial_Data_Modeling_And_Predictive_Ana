module QuickTests where

import Test.QuickCheck
import Secant

acc :: Double
acc = 1e-8

acc2 :: Double
acc2 = 1e-4

propZero e x = isZero e x == (abs x <= e)

linearF a b = \x -> a*x + b

squareF a b = \x -> a*x*x - b

propInvDerivative a b x0 x1 = x0 /= x1 ==> isZero acc ((invDerivative (linearF a b) x0 x1) - 1/a)

propLinearSolve a b x0 x1 = x0 /= x1 && a /= 0.0 ==> isZero acc ((root acc (Secant (linearF a b) (x0, x1))) + (b/a))

propSquareSolve a b x0 x1 = x0 /= x1 && a /= 0.0 && b >= 0.0 ==> isZero acc2 ((root acc (Secant (squareF a b) (x0, x1))) ** 2 - (b/a))

main :: IO ()
main = do
	quickCheck propZero
	quickCheck propInvDerivative
	quickCheck propLinearSolve
	quickCheck propSquareSolve
	return ()