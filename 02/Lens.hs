{-# LANGUAGE TemplateHaskell #-}
module Lens where

import Control.Lens
import Data.Time

data Quote = Quote {
    _bid        :: Double,
    _ask        :: Double,
    _bidVolume  :: Double,
    _askVolume  :: Double
    } deriving (Show)

makeLenses ''Quote
