{-# LANGUAGE QuasiQuotes, TypeFamilies, GeneralizedNewtypeDeriving, TemplateHaskell, OverloadedStrings, GADTs, FlexibleContexts #-}
module Main 
    ( module Quote2
    , main
    ) where

import Data.Time
import Database.Persist
import Database.Persist.TH
import Database.Persist.Sqlite
import Control.Monad.Trans.Resource (runResourceT)
import Control.Monad.IO.Class (liftIO)
import Quote2

main :: IO ()
main = do
    time <- getCurrentTime
    print time 
    runResourceT $ withSqliteConn ":memory:" $ runSqlConn $ do
        runMigration migrateAll
        firstId <- insert $ Quote time 1.2345 1.2355 100.0 120.0
        liftIO $ print firstId
        update firstId [QuoteBidVolume =. 230.0, QuoteAskVolume =. 180.0]
        secondId <- get firstId  -- it returns Maybe Quote
        case secondId of
            Nothing -> liftIO $ print "It's missing!"
            Just quote -> liftIO $ print quote
         
    print "End of program"
