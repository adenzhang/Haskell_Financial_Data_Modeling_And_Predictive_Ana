scanl :: (Vector v a, Vector v b) => (a -> b -> a) -> a -> v b -> v a
scanl f z <x1, x2,..., xn> = <y1, y2,..., yn, y(n+1)>
    where
        y1 = z
        yi = f y(i-1) x(i-1)