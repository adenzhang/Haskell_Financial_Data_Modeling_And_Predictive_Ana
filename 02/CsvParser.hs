{-# LANGUAGE OverloadedStrings #-}
module CsvParser (
      Quote (..)
    , csvFile
    , quote
    ) where

import Data.Attoparsec.Text
import Data.Attoparsec.Combinator
import Data.Text (Text, unpack)
import Data.Time
import System.Locale
import Data.Maybe

data Quote = Quote {
        qTime       :: LocalTime,
        qAsk        :: Double,
        qBid        :: Double,
        qAskVolume  :: Double,
        qBidVolume  :: Double
    } deriving (Show, Eq)

csvFile :: Parser [Quote]
csvFile = do
    q <- many1 quote
    endOfInput
    return q

quote   :: Parser Quote
quote   = do
    time        <- qtime
    qcomma
    ask         <- double
    qcomma
    bid         <- double
    qcomma
    askVolume   <- double
    qcomma
    bidVolume   <- double
    endOfLine
    return $ Quote time ask bid askVolume bidVolume 

qcomma  :: Parser ()
qcomma  = do 
    char ','
    return ()

qtime   :: Parser LocalTime
qtime   = do
    tstring     <- takeTill (\x -> x == ',')
    let time    = parseTime defaultTimeLocale "%d.%m.%Y %H:%M:%S%Q" (unpack tstring)
    return $ fromMaybe (LocalTime (fromGregorian 0001 01 01) (TimeOfDay 00 00 00 )) time

testString :: Text
testString = "01.10.2012 00:00:00.741,1.28082,1.28077,1500000.00,1500000.00\n" 

quoteParser = parseOnly quote
