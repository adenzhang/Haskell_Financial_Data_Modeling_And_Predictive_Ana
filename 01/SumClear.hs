import Data.Maybe

sumM ::  Num a => Maybe a -> Maybe a -> Maybe a
sumM ax ay = do
    x <- ax
    y <- ay
    return (x + y)
