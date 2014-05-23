safeLog x
    | x > 0.0   = Right (log x)
    | otherwise = Left  "Logarithm argument must be positive!"
