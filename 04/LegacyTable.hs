{-# LANGUAGE OverloadedStrings, QuasiQuotes, TemplateHaskell, TypeFamilies, GADTs, FlexibleContexts #-}
module LegacyTable where

import Database.Persist.TH
import Data.Time

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Tick sql=ticks_tmp
    day Day sql=dt
    time TimeOfDay sql=tt
    mksec Int sql=ms
    ask Double sql=Ask
    bid Double sql=Bid
    askVolume Double sql=AskVolume
    bidVolume Double sql=BidVolume
    UniqueTime day time mksec
    deriving Show
|]