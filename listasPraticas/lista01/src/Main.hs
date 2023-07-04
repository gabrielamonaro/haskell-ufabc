module Main (main) where
import Data.Char

{-Exercício 01: Faça uma função {mult3 n} que retorne True caso a entrada seja múltiplo de 3 e False caso contrário.-}
mult3 :: (Eq x, Num x, Integral x) => x -> Bool
mult3 n = if n`mod`3==0 then True else False

{-Exercício 02: Faça uma função {mult8 n} que retorne True caso a entrada seja múltiplo de 8 e False caso contrário.-}
mult8 :: (Eq x, Num x, Integral x) => x -> Bool
mult8 n = if n`mod`8==0 then True else False

{-Exercício 03: Faça uma função {mult83 x} que retorne True caso a entrada seja múltiplo de 3 e 8 e False caso contrário.-}
mult83 :: (Eq x, Num x, Integral x) => x -> Bool
mult83 n = if (mult3 n) && (mult8 n) then True else False

{-Exercício 04: Faça uma função {ehPrimo n} que determina se um número é primo..-}
ehPrimo :: Integral a => a -> Bool
ehPrimo n
 | (n == 1) = False
 | (calculaResto n (n-1)) = True
 | otherwise = False 
 
calculaResto :: Integral a => a -> a -> Bool
calculaResto n d = if n`mod`d /= 0 
                    then calculaResto n (d-1) 
                    else if
                      (d == 1)
                      then True
                      else False

{-Exercício 05: Faça uma função {bissextos} que retorne todos os anos bissextos até 2020, começando pelo ano 1584.-}
--múltiplos de 4; não são múltiplos de 100 - exceto os múltiplos de 400 

bissextos :: [Integer]
bissextos = [x | x <- [1584..2020], x `mod`4 == 0, testeBissextos x]

testeBissextos :: Integer -> Bool
testeBissextos n = 
  if (n `mod` 100 /= 0)
    then True
    else if (n `mod` 400 == 0)
      then True
      else False


{-Exercício 06: Faça uma função {lastNBissextos n} que encontre os N últimos anos bissextos.-}
lastNBissextos :: Int -> [Integer]
lastNBissextos n = 
  if (n < (length bissextos))
    then formaListaAnos n [] 
    else bissextos

pegaPrimeiroAno :: Int -> [Integer]
pegaPrimeiroAno n = [x | x <- bissextos, x == bissextos !! ((length bissextos) - n)]

formaListaAnos :: Int ->[Integer] -> [Integer]
formaListaAnos n listaAtual = 
  if (n > 1) 
    then pegaPrimeiroAno n ++ formaListaAnos (n-1) listaAtual
    else pegaPrimeiroAno n ++ listaAtual



{-Exercício 7: Faça uma função {stringToIntegers s} que recebe uma string s contendo somente números (e.g. ``01234") e devolva uma lista com os dígitos em formato Integer.-}
stringToIntegers :: String -> [Integer]
stringToIntegers s = map fromIntegral (map digitToInt s) :: [Integer]

{-Exercício 08: Faça uma funcao {ex8 x}  retorne True caso a entrada seja maior que -1 E (menor que 300 OU múltiplo de 6), e False caso contrário.-}
ex8 :: (Eq x, Num x, Integral x) => x -> Bool
ex8 n = 
  if (n > (-1)) && ((n < 300) || n`mod`6 == 0) then True 
  else False

{-Exercício 10:-}
subtrair :: Int -> Int -> Int
subtrair a b = a-b

dobro :: Int -> Int
dobro a = 2*a

quad :: Int -> Int
quad a = a*a

cumprimentar :: String -> IO ()
cumprimentar nome = putStrLn("Olá " ++ nome)

aniversario :: Int -> IO()
aniversario ano = putStrLn("Você fará " ++ show(2023-ano) ++ " anos em 2023!")


main :: IO ()
main = do
  putStrLn "hello world"
