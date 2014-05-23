module BarTypes 
    ( BarType (..)
    , duration
    ) where

data BarType = Bar1Min 
    | Bar5Min 
    | Bar10Min 
    | Bar30Min
    | Bar1Hour 
    | Bar4Hours 
    | Bar1Day
    deriving (Show, Eq, Enum)

totalDayMins :: Double
totalDayMins = 60.0*24.0

duration :: BarType -> Double
duration Bar1Min = 1.0 / totalDayMins
duration Bar5Min = 5.0 / totalDayMins
duration Bar10Min = 10.0 / totalDayMins
duration Bar30Min = 30.0 / totalDayMins
duration Bar1Hour = 60.0 / totalDayMins
duration Bar4Hours = 240.0 / totalDayMins
duration Bar1Day = 1.0