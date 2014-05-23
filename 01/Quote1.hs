type TimeStamp = Integer 

newtype Price = Price Double

data Quote = AskQuote TimeStamp Price | BidQuote TimeStamp Price
