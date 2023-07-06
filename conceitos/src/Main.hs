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


 ---------------------CONDICIONAIS

 {-If - Else -}
absoluto :: (Num a, Ord a) => a -> a
absoluto n = if n<0 then (-n) else n

confere :: (Num a, Ord a) => a -> a
confere n = if n < 0
           then -1
           else if n == 0
                then 0
                else 1

raizes2GrauV3 :: (Ord a, Floating a) => a -> a -> a -> (a,a)
raizes2GrauV3 a b c = (x1, x2) --funcao devolve uma tupla  
 where
  x1 = if delta >= 0 then ((-b)+ sqDelta)/(2*a) else 0
  x2 = if delta >= 0 then ((-b)- sqDelta)/(2*a) else 0
  sqDelta = sqrt delta
  delta = b^2 - 4*a*c


raizes2GrauV4 :: (Ord a, Floating a) => a -> a -> a -> (a,a)
raizes2GrauV4 a b c =
 if delta < 0
  then error "Delta Negativo" 
  else (x1, x2)
 where
  x1 = ((-b)+ sqDelta)/(2*a) 
  x2 = ((-b)- sqDelta)/(2*a)
  sqDelta = sqrt delta
  delta = b^2 - 4*a*c

nao :: Bool -> Bool
nao x = if x then False else True

{-Guards-}

confereV2 :: (Num a, Ord a) => a -> a
confereV2 n
 | n<0 = -1
 | n==0 = 0 
 | otherwise = 1

naoV2 :: Bool -> Bool
naoV2 x
 | x = False
 | otherwise = True


{- Pattern Matching-}
naoV3 :: Bool -> Bool
naoV3 True = False
naoV3 False = True

soma :: (Eq a, Num a) => a -> a -> a
soma 0 y = y
soma x 0 = x
soma x y = x + y

mult :: (Eq a, Num a) => a -> a -> a
mult 0 y = 0
mult x 0 = 0
mult 1 y = y
mult x 1 = x
mult x y = x * y




main :: IO ()
main = do
  putStrLn "hello world"
