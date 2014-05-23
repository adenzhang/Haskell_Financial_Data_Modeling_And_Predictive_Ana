newtype Price = Price Double
    deriving (Ord, Show, Eq)

inverse (Price 0.0) = Price (0.0)
inverse (Price x) = Price (1/x)
