type TimeStamp = Integer

newtype Price = Price Double

data Quote = AskQuote TimeStamp Price | BidQuote TimeStamp Price

inverse (AskQuote _ (Price x)) = 1/x
inverse (BidQuote _ (Price x)) = 1/x
