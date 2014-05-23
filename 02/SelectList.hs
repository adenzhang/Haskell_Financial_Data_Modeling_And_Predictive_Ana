quotes <- selectList [ QuoteBid >=. 1.0, QuoteBid <=1.2 ]
    [ Asc QuoteTime
    , LimitTo 1000
    , OffsetBy 500
    ]
