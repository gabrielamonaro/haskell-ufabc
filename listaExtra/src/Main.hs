module Main (main) where

-- Ex 1
-- subLista :: Eq a => [a] -> [a] -> Bool
-- subLista [] = True
-- subLista _ [] = False
-- subLista rs@(x:xs)(y:ys) |x == y = sublista xs ys
                         -- | otherwise = sublista rs ys

todas :: [a] -> [[a]]
todas [] = [[]]
todas (x:xs) = zss ++ [x:zs | zs <- zss]
  where zss = todas xs

crescente :: Ord a => [a] -> Bool
crescente [] = True
crescente [_] = True
crescente (x:rs@(y:_)) = x < y && crescente rs
-- crescente (x:y:ys) = x < y && crescente (y:ys)

--Ex. 4

scm :: Ord a => [a] -> [a]
scm xs = maxBy length [zs | zs <- todas xs, crescente zs]


maxBy :: Ord b => (a-> b) -> [a] -> a
maxBy _ [] = error "lista vazia"
maxBy _ [x] = x
maxBy key (x:xs) | key x > key m = x
                 | otherwise = m
                 where m = maxBy key xs

main :: IO ()
main = do
  putStrLn "hello world"
  print (scm [4::Int, 1, 2, 1, 4, 2, 5, 6, 1, 2])