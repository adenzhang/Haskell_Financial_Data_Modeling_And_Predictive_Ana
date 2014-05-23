import Data.Maybe

sumM ::  Num a => Maybe a -> Maybe a -> Maybe a
sumM ax ay = ax >>= (\x -> ay >>= (\y -> return (x + y) ) )
