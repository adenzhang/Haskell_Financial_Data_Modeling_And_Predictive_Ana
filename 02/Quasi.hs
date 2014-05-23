{-# LANGUAGE TemplateHaskell, QuasiQuotes, TypeFamilies, GADTs #-}
module Quasi where

import Data.Text (Text)
import Database.Persist
import Database.Persist.TH
import Database.Persist.Sqlite
import Database.Persist.Quasi

share [mkPersist sqlSettings] [persistLowerCase|
Trade
    ask Double
    bid Double
|]


