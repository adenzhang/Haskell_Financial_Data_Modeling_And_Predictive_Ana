import Criterion.Main (defaultMain, bench, whnf)

factorial :: Integer -> Integer
factorial 0 = 1
factorial 1 = 1
factorial n = n * factorial (n-1)

main :: IO ()
main = defaultMain [
        bench "factorial 100" $ whnf factorial 100
    ]