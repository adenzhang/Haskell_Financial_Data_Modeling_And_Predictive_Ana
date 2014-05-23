quotes <- selectList ([ QuoteBid >=. 1.0, QuoteBid <=1.2 ]
    ||. [QuoteAsk >= 0.8, QuoteAsk <= 0.9]) 
    []
liftIO $ print quotes
