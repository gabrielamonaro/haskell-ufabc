module Main (main) where

import Data.Char (isAlphaNum, digitToInt)

-- Função multiplicar, que recebe dois valores inteiros e retorna o produto do primeiro pelo segundo
multiplicar :: Int -> Int -> Int
multiplicar x y = x * y

-- Função cumprimentar, que recebe um nome e retorna "A linguagem preferida de nome é Haskell" (considere o operador de concatenação ++)
cumprimentar :: String -> String
cumprimentar nome = "A linguagem preferida de " ++ nome ++  " é Haskell"

-- Função velocidade, que recebe uma distância em km e a quantidade de horas que ela levou para ser percorrida, ambos do tipo Float, e retorna a string "Isso equivale a {x} km por hora!"
velocidade :: Float -> Float -> String
velocidade distancia tempo = "Isso equivale a "++ show(distancia/tempo) ++" kilômetros por hora!"

-- Função mult7 n que retorne True caso a entrada seja múltiplo de 7 e False caso contrário.
mult7 :: Int -> Bool
mult7 x = if x `mod`7 == 0 then True else False

-- Função somaEhMult7, que recebe um dois valores inteiros e retorna se a soma é múltipla de 7
somaEhMult7 :: Int -> Int -> Bool
somaEhMult7 a b =  mult7 (a + b)

-- Faça uma função estaNoIntervalo a b c que recebe três inteiros e decida se a está contido no intervalo fechado entre o b e c. Assuma que b < c sempre.
estaNoIntervalo :: Int -> Int -> Int -> Bool
estaNoIntervalo a b c = if (a >= b) && (a<=c) then True else False

-- Faça uma função todosNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se todos os números da primeira lista estão no intervalo descrito pelo segundo e terceiro argumento.
todosNoIntervalo :: [Int] -> Int -> Int -> Bool
todosNoIntervalo as b c = length (concat(map (retornoIntervalo b c) as)) == length as 

retornoIntervalo :: Int -> Int -> Int -> [Int]
retornoIntervalo b c a = if estaNoIntervalo a b c then [a] else []

-- Similarmente, faça uma função algumNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se pelo menos um dos números da primeira lista está no intervalo descrito pelo segundo e terceiro argumento.
algumNoIntervalo :: [Int] -> Int -> Int -> Bool
algumNoIntervalo [] b c = False
algumNoIntervalo as b c =
  if retornoIntervalo b c (as !! 0) == [as !! 0] 
    then True 
    else algumNoIntervalo (tail as) b c

-- Faça uma função ehPerfeito n que determine se um número é perfeito.
ehPerfeito :: Int -> Bool
ehPerfeito n = sum (todosDivisores n (n-1) []) == n 

todosDivisores :: Int -> Int -> [Int] -> [Int]
todosDivisores n c listaAtual = 
  if c > 0
    then
      if n `mod` c == 0 
        then todosDivisores n (c-1) (listaAtual ++ [c]) 
        else todosDivisores n (c-1) listaAtual
    else listaAtual


-- Faça uma função procuraSeis que retorne todos os os números entre 0 e 999 cuja soma dos dígitos é 6.
-- somaDigitosSeis :: ???
somaDigitosSeis x = undefined

lista = [0..999]
procuraSeis :: [Int]
procuraSeis = concat (map res6 lista) 

intParaString :: Int -> String
intParaString x = show x

divideDigitos :: String -> [Int]
divideDigitos str = map digitToInt str

res6 :: Int -> [Int]
res6 x = 
  if 
    sum (divideDigitos (intParaString x)) == 6
    then [x]
    else [] 


comprimentoAoQuadrado :: [String] -> [Int]
comprimentoAoQuadrado xs = map square (map length xs)  

square :: Int -> Int 
square n = n*n

findLast :: (a -> Bool) -> [a] -> a
findLast f xs = head(reverse ( concat (map (verifica f) xs)))  

verifica ::  (a -> Bool) -> a -> [a]
verifica f x = if (f x) then [x] else []

--gerarUsuarios
gerarUsuarios :: Int -> String -> [String]
gerarUsuarios n str = geraAux n str []  

geraAux :: Int -> String -> [String] -> [String]
geraAux n str listaAtual = 
  if length listaAtual < (n)
    then geraAux n str (listaAtual ++ [str ++ show(length listaAtual + 1)])
      else listaAtual
--

--descontoDaSorte
descontoDaSorte :: [Int] -> [Int]
descontoDaSorte xs = (concat(map ((verifica2 mult7)) xs))

verifica2 ::  (Int -> Bool) -> Int -> [Int]
verifica2 f x = if f (x-10) then [] else [x-10]
--

--limparUserNames
limparUsernames :: [String] -> [String]
limparUsernames xss = map alteraString xss

alteraString :: String -> String
alteraString xs = concat (map removeChar xs)

removeChar :: Char -> [Char]
removeChar x = if isAlphaNum x then [x] else []
--

--maisDaMetade
maisDaMetade :: (a -> Bool) -> [a] -> Bool
maisDaMetade f xs = (fromIntegral(length (concat (map (verifica f) xs))):: Float) > (metade xs)

metade :: [a] -> Float
metade xs = (fromIntegral(length xs) :: Float)/2
--

--
filterDesastrado :: (a -> Bool) -> [a] -> [a]
filterDesastrado f xs =  verificaF f [] xs

verificaF ::  (a -> Bool) -> [a] -> [a] -> [a]
verificaF f listaAtual [] = listaAtual
verificaF f listaAtual xs =
  if length xs > 0
    then 
      if f (xs !! 0)
        then verificaF f (listaAtual ++ [xs !! 0]) (tail xs)
        else 
          if length listaAtual == 0
            then
              verificaF f [] (tail xs) 
            else
              verificaF f (init listaAtual) (tail xs) 
    else
      listaAtual
-------

palavraMaisLonga :: [String] -> String
palavraMaisLonga conjunto = comparaMaiorPalavra conjunto

pegaMaiorTamanho :: [String] -> Int
pegaMaiorTamanho conjunto = maximum (map length conjunto)

comparaMaiorPalavra :: [String] -> String
comparaMaiorPalavra conjunto = 
  if length (conjunto!!0) == pegaMaiorTamanho conjunto
    then conjunto!!0
    else comparaMaiorPalavra (tail conjunto)

--

jogadorBlackJack :: [Int] -> Bool
jogadorBlackJack lista = somaBlackJack 0 lista

somaBlackJack :: Int -> [Int] -> Bool
somaBlackJack somaAtual [] = somaAtual <= 21
somaBlackJack somaAtual lista = 
   if somaAtual + head lista >= 18
    then somaAtual + head lista <= 21
    else somaBlackJack (somaAtual + head lista) (tail lista)


main :: IO ()
main = do
  putStrLn "hello world"
