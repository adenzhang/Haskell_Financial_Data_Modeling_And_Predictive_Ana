module Secant 
	( Secant (..)
	, isZero
	, invDerivative
	, step
	, root
	) where

-- Either it is converged to the point, or the previous two values and function are supplied
data Secant = ConvergedSecant Double | Secant (Double -> Double) (Double, Double)

isZero :: Double -> Double -> Bool
isZero eps x = (x <= eps) && (x >= -eps)

invDerivative :: (Double -> Double) -> Double -> Double -> Double
invDerivative f x1 x0 = (x1 - x0) / ((f x1) - (f x0))

step :: Double -> Secant -> Secant
step _ a@(ConvergedSecant _) = a

step eps a@(Secant f (x0, x1)) 
	| isZero eps f2	= ConvergedSecant x2
	| otherwise		= Secant f (x2, x1)
	where	
		x2 = x1 - (f x1) * (invDerivative f x1 x0)
		f2 = f x2

root :: Double -> Secant -> Double
root _ (ConvergedSecant x) = x
root eps d = root eps (step eps d)
