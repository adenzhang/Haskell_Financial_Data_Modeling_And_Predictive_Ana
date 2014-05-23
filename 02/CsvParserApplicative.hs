{-# LANGUAGE OverloadedStrings #-}
module CsvParser (
      Quote (..)
    , csvFile
    , quote
    ) where

import Control.Applicative
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
csvFile = many1 quote <* endOfInput 

quote   :: Parser Quote
quote   = Quote <$> (qtime <* qcomma)
                <*> (double <* qcomma)
                <*> (double <* qcomma)
                <*> (double <* qcomma)
                <*> (double <* endOfLine)

qcomma  :: Parser ()
qcomma  = char ',' *> pure ()

qtime   :: Parser LocalTime
qtime   = createTime <$> takeTill (\x -> x == ',')
    where   defaultTime = LocalTime (fromGregorian 0001 01 01) (TimeOfDay 00 00 00 )
            parseTimeText t = parseTime defaultTimeLocale "%d.%m.%Y %H:%M:%S%Q" (unpack t)
            createTime x = fromMaybe defaultTime $ parseTimeText x

testString :: Text
testString = "01.10.2012 00:00:00.741,1.28082,1.28077,1500000.00,1500000.00\n" 

quoteParser = parseOnly quote
