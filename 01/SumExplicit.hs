
sumM ::  Num a => Maybe a -> Maybe a -> Maybe a
sumM ax ay = 
    case ax of
        Nothing -> Nothing
        Just x  -> case ay of
            Nothing -> Nothing
            Just y  -> Just (x+y)
