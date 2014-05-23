{-# LANGUAGE OverloadedStrings, TypeFamilies, GADTs, FlexibleContexts #-}
module Main 
    where

import Database.Persist
import Database.Persist.MySQL
import Data.Time
import qualified Data.Map as M
import Control.Monad.Trans.Resource (runResourceT)
import Control.Monad.Logger (runStderrLoggingT)
import Control.Monad.IO.Class (liftIO)
import CollectStats (collectStats, Stat(..))

import LegacyTable

mysqlConn :: ConnectInfo
mysqlConn = defaultConnectInfo { 
    connectPassword = "arimasen", 
    connectDatabase = "pricer" }

day :: Day
day = fromGregorian 2013 06 25

prettyPrint :: [(Double, Double)] -> IO ()
prettyPrint = mapM_ (\(a,b) -> do
    putStr $ show a
    putStr ","
    print b
    )

main :: IO ()
main = withMySQLConn mysqlConn $ \conn ->
    runResourceT $ runStderrLoggingT $ flip runSqlConn conn $ do
        printMigration migrateAll
        runMigration migrateAll
        ticks <- selectList [TickDay ==. day] [Asc TickTime, Asc TickMksec]
        let stats = collectStats $ map entityVal ticks
        liftIO $ print stats
        liftIO $ prettyPrint $ M.toList $ stHisto stats
        return ()