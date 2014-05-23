import Data.Time

data Trade = Trade {
        tTime       :: LocalTime,
        tPrice      :: Double,
        tVolume     :: Double
    } deriving (Show, Eq)

data Quote = Quote {
        qTime       :: LocalTime,
        qAsk        :: Double,
        qBid        :: Double,
        qAskVolume  :: Double,
        qBidVolume  :: Double
    } deriving (Show, Eq)

-- time, price and volume
data Order = BuyLimit   LocalTime Double Double
    | BuyStop           LocalTime Double Double
    | SellLimit         LocalTime Double Double
    | SellStop          LocalTime Double Double
    deriving (Show, Eq) 
