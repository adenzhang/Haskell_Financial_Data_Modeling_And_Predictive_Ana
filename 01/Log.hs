safeLog x
    | x > 0.0   = Just (log x)
    | otherwise = Nothing
