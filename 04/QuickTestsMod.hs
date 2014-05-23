import Test.QuickCheck
import Test.QuickCheck.Modifiers
import Secant

acc :: Double
acc = 1e-8

acc2 :: Double
acc2 = 1e-4

squareF a b = \x -> a*x*x - b

propSquareSolve (Positive a) (NonNegative b) (Positive x0) = 
	x0 <= b/a ==> isZero acc2 ((root acc (Secant (squareF a b) (0.0, x0))) ** 2 - (b/a))

main :: IO ()
main = do
	quickCheck propSquareSolve
	return ()