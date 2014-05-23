data T = T !Int !Int
    deriving (Show)
    
f :: Int -> T
f x = T (x+1) (x+1)

f' :: Int -> T
f' x = T y y
    where y = x +1