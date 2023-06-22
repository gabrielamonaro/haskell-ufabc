module Main (main) where

square :: Int -> Int --quadrado somente para o tipo Int
square x = x * x

quadrado :: Num a => a -> a --quadrado de qualquer número - independente do tipo
quadrado x = x * x

quadradoMais6Mod9 :: Integral a => a -> a
quadradoMais6Mod9 x  = (x + 6) `mod` 9

raizes2Grau :: Floating a => a -> a -> a -> (a,a)
raizes2Grau a b c = (((-b) + sqrt(b^2 - 4*a*c))/(2*a),
                     ((-b) - sqrt(b^2 - 4*a*c))/(2*a)) --funcao devolve uma tupla  

raizes2GrauV2 :: Floating a => a -> a -> a -> (a,a)
raizes2GrauV2 a b c = (x1, x2) --funcao devolve uma tupla  
 where
  x1 = ((-b)+ sqDelta)/(2*a)
  x2 = ((-b)- sqDelta)/(2*a)
  sqDelta = sqrt delta
  delta = b^2 - 4*a*c

polinomio :: Int -> Int
polinomio x = x*x + 10*x + 2

soma :: Float -> Float -> Float
soma a b = a + b

triplica :: Int -> Int
triplica var = var * 3

areaCirculo :: Float -> Float
areaCirculo raio = raio * raio * pi

perimetroCirculo :: Float -> Float
perimetroCirculo raio = 2*pi*raio

hipotenusa :: Float -> Float -> Float
hipotenusa a b = sqrt(a*a + b*b)  

diferenca :: Float -> Float -> Float
diferenca r1 r2 = abs (areaCirculo(r1) - areaCirculo(r2))

tamanho :: [a] -> Int --retorna o tamanho de uma lista
tamanho [] = 0
tamanho (_:xs) = 1 + tamanho xs

absoluto n = if n < 0 then (-n) else n 

main :: IO ()
main = do
  putStrLn "hello worlds"
  print (square 6)
  print $ square 6  
  print (polinomio 2)
  print (soma 1 2)
  print (triplica 1)
  print(areaCirculo 1)
  print(perimetroCirculo 1)
  print(hipotenusa 3 4)
  print(diferenca 10 11)
  print(raizes2GrauV2 10 11 12)

