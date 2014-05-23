{-# LANGUAGE QuasiQuotes, TypeFamilies, GeneralizedNewtypeDeriving, TemplateHaskell, OverloadedStrings, GADTs, FlexibleContexts #-}
module Quote2  where

import Data.Time
import Database.Persist
import Database.Persist.TH
import Database.Persist.Sqlite

share [mkSave "quoteDef", mkPersist sqlSettings, mkMigrate "migrateAll"] [persist|
Quote
    time        UTCTime
    ask         Double
    bid         Double
    askVolume   Double
    bidVolume   Double
    deriving Show
|]

