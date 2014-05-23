import Data.Maybe
import Data.List

safeLog :: Double -> Maybe Double
safeLog x
    | x > 0.0   = Just (log x)
    | otherwise = Nothing

sumLog :: [Double] -> [Maybe Double]
sumLog xs = do
    x <- xs
    return $ safeLog x
