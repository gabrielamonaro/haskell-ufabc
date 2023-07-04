module Main (main) where

raiz2Grau :: (Floating a, Ord a) => a -> a -> a -> (a,a)
raiz2Grau a b c 
 | delta < 0 = error "Delta negativo."
 | otherwise = (x,y)
 where 
  delta = (b*b) - (4*a*c)
  x = if (delta < 0) then 0 else ((-b) + sqrt delta)/(2*a)
  y = if (delta < 0) then 0 else ((-b) - sqrt delta)/(2*a)
  
sig :: (Ord a, Num a) => a -> a
sig n
  | n == 0 = 0 
  | n > 0 = 1
  | otherwise = -1

somaMultX :: Num a => a -> (a -> a)
somaMultX x = \y -> x + x*y

pares = [(x, even x) | x <- [1,2,3]]

concatena xss = [x | xs <- xss, x <- xs]

-- x está contido em xs, e xs está contido em xss
-- dessa forma, estamos definindo que cada x

tamanho xs = sum [1 | _ <- xs]
-- [1 | _ <- xs] cria uma lista de elementos do tipo 1 a cada valor _ pertencente a lista xs


divisores :: Int -> [Int]
divisores n = [x | x <- [1..n], n`mod`x == 0]

primo :: Int -> Bool
primo n = divisores n == [1,n]

pairs :: [a] -> [(a,a)]
pairs xs = zip xs (tail xs) 

sorted :: Ord a => [a] -> Bool
sorted xs = and [ x <= y | (x,y) <- pairs xs] 

insert :: Ord a => [a] -> a -> [a]
insert [] x = [x]
insert (y:ys) x  
 | x <= y = x:y:ys
 |otherwise = y : insert ys x


main :: IO ()
main = do
  putStrLn "hello world"
