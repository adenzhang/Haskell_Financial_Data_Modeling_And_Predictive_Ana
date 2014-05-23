{-# LANGUAGE QuasiQuotes, TypeFamilies, GeneralizedNewtypeDeriving, TemplateHaskell, OverloadedStrings, GADTs #-}
module Quote  where

import Data.Time
import Database.Persist
import Database.Persist.TH
import Database.Persist.Sqlite
import Database.Persist.EntityDef

{-
data Quote = Quote {
        qTime       :: UTCTime,
        qAsk        :: Double,
        qBid        :: Double,
        qAskVolume  :: Double,
        qBidVolume  :: Double
    } deriving (Show, Eq)
-}

mkPersist sqlSettings [persist|
Quote
    time        UTCTime
    ask         Double
    bid         Double
    askVolume   Double
    bidVolume   Double
    deriving Show
|]

