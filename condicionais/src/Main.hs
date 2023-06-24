module Main (main) where

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
  print(lista !! 1)

