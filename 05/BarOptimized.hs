module BarOptimized 
    ( Bar (..)
    )where

import BarTypes (BarType)
import Data.Time (UTCTime)

data Bar = Bar {
    bType     :: BarType,
    bStamp    :: {-# UNPACK #-} !UTCTime,
    bOpen     :: {-# UNPACK #-} !Double,
    bLow      :: {-# UNPACK #-} !Double,
    bHigh     :: {-# UNPACK #-} !Double,
    bClose    :: {-# UNPACK #-} !Double
} deriving (Show)