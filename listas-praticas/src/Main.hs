module Main (main) where

--1. Faça uma função integersDePrimos xs que receba uma lista de inteiros e retorna uma lista de inteiros com os números primos contidos na lista original (dica: na lista da semana passada havia uma questão para desenvolver uma função que informava se um número é primo ou não).

integersDePrimos :: [Int] -> [Int]
integersDePrimos xs = concat (map retornaPrimo xs)

retornaPrimo:: Int -> [Int]
retornaPrimo x = if ehPrimo x then [x] else []

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

--2. Faça uma função bissextos32 que retorna uma lista com os anos bissextos entre 1584 e 2016 que são múltiplos de 32 (dica: na lista da semana passada havia uma questão para encontrar os anos bissextos), em que cada elemento dessa nova lista é uma string. A lista deve estar em ordem decrescente.

bissextos32::[String]
bissextos32 = concat (map mult32 bissextos)

mult32:: Int -> [String]
mult32 x = if x`mod`32==0 then [show(x)] else []

bissextos :: [Int]
bissextos = [x | x <- [1584..2020], x `mod`4 == 0, testeBissextos x]

testeBissextos :: Int -> Bool
testeBissextos n = 
  if (n `mod` 100 /= 0)
    then True
    else if (n `mod` 400 == 0)
      then True
      else False

--3. Desenvolva uma função pop, que recebe uma lista e um Integer n. Ela retorna a lista sem o n-ésimo elemento (indexado em 0).
pop :: Eq a => [a] -> Int -> [a]
pop xs 0 = tail xs
pop xs i = concat (map (ehPosicao a) xs)
  where a = xs!!i

ehPosicao :: Eq a => a -> a -> [a]
ehPosicao y x = if x == y then [] else [x]



--4.Desenvolva uma função range, que recebe uma lista e dois Integers, i, j. Ela retorna a sublista com os elementos do índice i (inclusivo) a j (exclusivo), similar à função range da linguagem Python.

--5. Desevolva uma função palindrome que recebe uma palavra (String) e retorne True caso ela seja palíndrome, ou False caso contrário. Não utilize a função reverse.

main :: IO ()
main = do
  putStrLn "hello world"
