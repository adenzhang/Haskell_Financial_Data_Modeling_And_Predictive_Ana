module Bar 
    ( Bar (..)
    )where

import BarTypes (BarType)
import Data.Time (UTCTime)

data Bar = Bar {
    bType     :: BarType,
    bStamp    :: UTCTime,
    bOpen     :: Double,
    bLow      :: Double,
    bHigh     :: Double,
    bClose    :: Double
} deriving (Show)