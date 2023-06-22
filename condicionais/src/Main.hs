module Main (main) where

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

{-Exercício 01: Faça uma função {mult3 n} que retorne True caso a entrada seja múltiplo de 3 e False caso contrário.-}
mult3 :: (Eq x, Num x, Integral x) => x -> Bool
mult3 n = if n`mod`3==0 then True else False

{-Exercício 02: Faça uma função {mult8 n} que retorne True caso a entrada seja múltiplo de 8 e False caso contrário.-}
mult8 :: (Eq x, Num x, Integral x) => x -> Bool
mult8 n = if n`mod`8==0 then True else False

{-Exercício 03: Faça uma função {mult83 x} que retorne True caso a entrada seja múltiplo de 3 e 8 e False caso contrário.-}
mult83 :: (Eq x, Num x, Integral x) => x -> Bool
mult83 n = if (mult3 n) && (mult8 n) then True else False


main :: IO ()
main = do
  putStrLn "hello world"

