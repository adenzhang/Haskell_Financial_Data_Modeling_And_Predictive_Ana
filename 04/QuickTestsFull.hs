import Test.QuickCheck
import Test.QuickCheck.Modifiers
import Secant

acc :: Double
acc = 1e-8

acc2 :: Double
acc2 = 1e-4

args :: Args
args = Args 
	{ replay          = Nothing
  	, maxSuccess      = 100
  	, maxDiscardRatio = 100
  	, maxSize         = 100
  	, chatty          = True
  	}

propZero e x = isZero e x == (abs x <= e)

linearF a b = \x -> a*x + b

squareF a b = \x -> a*x*x - b

propInvDerivative (NonZero a) b x0 x1 = x0 /= x1 ==> isZero acc ((invDerivative (linearF a b) x0 x1) - 1/a)

propLinearSolve (NonZero a) b x0 x1 = x0 /= x1 ==> isZero acc ((root acc (Secant (linearF a b) (x0, x1))) + (b/a))

propSquareSolve (Positive a) (NonNegative b) (Positive x0) = 
	x0 <= b/a ==> isZero acc2 ((root acc (Secant (squareF a b) (0.0, x0))) ** 2 - (b/a))

main :: IO ()
main = do
	quickCheckWith args propZero
	quickCheckWith args propInvDerivative
	quickCheckWith args propLinearSolve
	quickCheckWith args propSquareSolve
	return ()