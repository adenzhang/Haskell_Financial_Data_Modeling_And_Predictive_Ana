factorial ::  (Eq a, Num a) => a -> a
factorial n = n * factorial (n-1)
factorial 0 = 1
