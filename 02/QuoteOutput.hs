type QuoteId =
  KeyBackend Database.Persist.GenericSql.Raw.SqlBackend Quote

data QuoteGeneric backend
  = Quote {quoteTime :: UTCTime,
           quoteAsk :: Double,
           quoteBid :: Double,
           quoteAskVolume :: Double,
           quoteBidVolume :: Double}

type Quote =
        QuoteGeneric Database.Persist.GenericSql.Raw.SqlBackend

instance PersistEntity (QuoteGeneric backend) where
    ...    
