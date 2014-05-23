import Data.Time
import Data.List

data Trade = Trade {
        tTime       :: LocalTime,
        tPrice      :: Double,
        tVolume     :: Double
    } deriving (Show, Eq)

sortedPrices :: [Trade] -> [Double]
sortedPrices = map tPrice . sortBy compareTradeTime 
    where   compareTradeTime (Trade a _ _) (Trade b _ _) = compare a b 

normalize :: [Trade] -> [Double]
normalize               = normalize' . sortedPrices 

-- eats already sorted list of prices
normalize' :: [Double] -> [Double]
normalize' prices       = map diff zippedX
    where logX          = map log prices
          zippedX       = zip (tail logX) logX
          diff (a, b)   = a - b
-- Test data

testDay    = fromGregorian 2013 02 01
testTime x = LocalTime testDay (TimeOfDay 10 00 x)

testTrades = [Trade (testTime 2) 1.2342 10.0, Trade (testTime 1) 1.3266 12.0, Trade (testTime 3) 1.2349 15.0]

