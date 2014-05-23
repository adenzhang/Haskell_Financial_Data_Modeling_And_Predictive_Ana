quotes <- selectList [ QuoteBid >=. 1.0, QuoteBid <=1.2 ] []
liftIO $ print quotes
