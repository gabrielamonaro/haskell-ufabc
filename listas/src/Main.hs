module Main (main) where
import Data.List (sort)

----------------------LISTA01
-- 1. Coloque parênteses nas seguintes expressões:
-- 2^(3*4)
-- 2*(3+4)*5
-- (2+3)*4^5
-- (2+3)/(4-5)^6*7

-- 2. Sem utilizar qualquer ajuda, determine o valor e o tipo retornado por essas expressões. Em seguida, utilize o ghci para confirmar a resposta:
-- (* 9) 6 ==> 54
-- head [(0,"doge"),(1,"kitteh")] => (0,"doge")
-- head [(0 :: Integer ,"doge"),(1,"kitteh")] => (0,"doge")
-- if False then True else False => False
-- length [1, 2, 3, 4, 5] => 5
-- length [1, 2, 3, 4] > length "TACOCAT" => False

-- 3. Defina uma função para seguinte assinatura:
f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f dupla1 dupla2 = ((segundo dupla1, segundo dupla2), (primeiro dupla1, primeiro dupla2))

primeiro :: (a,b) -> a
primeiro (x, _ )= x 

segundo :: (a,b) -> b
segundo (_,x) = x 

devolveDupla :: a -> a -> (a,a)
devolveDupla x y = (x,y)

-- 4. Defina uma função
palindromo :: (Eq a) => [a] -> Bool
palindromo xs = reverse xs == xs

-- 5. Mostre que a seguinte função curried pode ser formalizada em termos de expressões lambda:
mult :: Int -> Int -> Int -> Int
mult x y z = x*y*z
-- \x y z -> x * y * z

-- 6. Mostre como o operador || pode ser definido de quatro modos diferentes usando pattern matching.
ou :: Bool -> Bool -> Bool
True `ou` _ = True
_ `ou` True = True
False `ou` False = False 

ou2 :: Bool -> Bool -> Bool
ou2 True _ = True
ou2 False y = y


-- 7. Sem usar outras bibliotecas, funções ou operadores, mostre que a definição por pattern matching de &&
-- True && True = True
-- _ && _ = False
-- pode ser formalizada utilizando duas expressões condicionais (if) aninhadas

ee :: Bool -> Bool -> Bool
ee a b = 
  if a
    then 
      if b
        then True
        else False
    else False     


-- 8. Faça o mesmo do exercício anterior para essa definição alternativa de
-- &&:
-- True && b = b
-- False && _ = False
-- usando dessa vez uma única expressão condicional.

ee2 :: Bool -> Bool -> Bool
ee2 a b = 
  if a
    then b
    else False    

-- 9. Defina a única função possível para a assinatura
c :: a -> b -> a
c a _ = a

-- 10. Defina a única função possível para a assinatura
co :: (b -> c) -> (a -> b) -> a -> c
co f g x = f g a



----------------------------LISTA 02
-- import Data.List (sort)
-- 1. Defina uma função
penultimo :: [a] -> a
-- que devolve o penúltimo elemento de uma lista, apresentando uma mensagem de erro nos casos de lista vazia e lista com apenas um elemento.
penultimo [] = error "Lista vazia"
penultimo xs = head (tail (reverse xs))

-- 2. Defina uma função
maximoLocal :: [Int] -> [Int]
-- que devolve uma lista com os máximos locais de uma lista de inteiros. Um máximo local é um elemento maior que seu antecessor e que seu sucessor. Por exemplo, em [1,3,4,2,5] 4 é um máximo local, mas 5 não, pois não possui sucessor.

maximoLocal xs = achaMaximo xs []
  
achaMaximo :: [Int] -> [Int] -> [Int]
achaMaximo [] listaAtual = listaAtual
achaMaximo (x:[]) listaAtual = listaAtual
achaMaximo (x:y:[]) listaAtual = listaAtual
achaMaximo xs listaAtual = 
  if (meio > anterior) && ( meio > sucessor)
    then achaMaximo (tail xs) listaAtual ++ [meio]
    else achaMaximo (tail xs) listaAtual
 where
  meio = head (tail xs)
  anterior = head xs
  sucessor = head (tail (tail xs))


-- 3. Usando compreensão de listas, defina a função
perfeitos :: Int -> [Int]
-- que recebe um inteiro n e retorna uma lista dos números perfeitos até n. Um número perfeito é igual à soma de seus fatores, excluindo a si mesmo. O número 28 é perfeito, pois 1 + 2 + 4 + 7 + 14 = 28.
-- Exemplo:
-- > perfeitos 500
-- [6,28,496]
perfeitos n = concat (map ehPerfeito [1..n])

ehPerfeito :: Int -> [Int]
ehPerfeito n =  
  if 
    sum [x | x <- [1..(n-1)] , n `mod` x == 0] == n
    then [n]
    else []

-- 4. Defina a função 
produtoEscalar :: Num a => [a] -> [a] -> a
-- que devolve o produto escalar de dois vetores, usando compreensão de listas. v · w = v1 * w1 + v2 * w2 + ... + vn * wn
produtoEscalar xs ys = sum[x*y | (x,y) <- zip xs ys]

-- 5. Escreva uma função recursiva
palindromo :: [Int] -> Bool
-- que verifica se os elementos da lista formam um palíndromo.
palindromo xs = reverse xs == xs 

-- 6. Defina uma função que ordene uma lista de listas pelo tamanho de suas sublistas.
qsort :: (Ord b) => (a -> b) -> [a] -> [a]
qsort _ [] = []
qsort key (x:xs) = 
  qsort key menores ++ [x] ++ qsort key maiores
  where
    menores = [z | z <- xs, key z <= key x]
    maiores = [z | z <- xs, key z > key x]

ordenaListas :: [[a]] -> [[a]]
ordenaListas xss = qsort length xss 

-- 7. Mostre como a compreensão de lista
coord :: [a] -> [a] -> [(a,a)]
coord x y = [(i,j) | i <- x, j <- y]
que possui duas funções geradoras, pode ser redefinida com duas listas de compreensão aninhadas, cada uma contendo uma única função geradora.
coord xs ys = concat [[(x,y) | y <- ys] | x <- xs]

-- 8. O algoritmo de Luhn para a verificação dos dígitos de um cartão de
-- crédito segue os seguintes passos:
-- (a) considere cada dígito como um número
-- (b) a partir da direita, dobre os números alternadamente, começando
-- pelo penúltimo
-- (c) some todos os dígitos dos números
-- (d) se o total for divisível por 10, o número do cartão é válido.
-- Em seguida:
-- (a) Defina as funções
-- digitosRev :: Int -> [Int]
-- que converte um inteiro em uma lista contendo seus dígitos na
-- ordem reversa.
-- (b) Escreva a função
-- dobroAlternado :: [Int] -> [Int]
-- que recebe uma lista de números e dobra a partir da esquerda o
-- segundo, quarto etc, elemento, devolvendo uma lista atualizada.
-- Note que por termos escrito a função anterior para retornar os
-- dígitos invertidos, podemos fazer essa operação da esquerda ao
-- invés de da direita conforme descrição do algoritmo. Por exemplo,
-- para [3,5,6,4] a a saída é [3,10,6,8].
-- (c) Defina a função
-- somaDigitos :: [Int] -> Int
-- que soma todos os dígitos da lista de inteiros. Com o uso função
-- anterior, alguns números possuem dois dígitos, que precisam ser
-- somados individualmente. Exemplo: [6,5,12,4] = 6 + 5 + 1 + 2
-- + 4 = 18
-- (d) Utilize as funções criadas anteriormente para definir a função
-- luhn :: Int -> Bool
-- que verifica se o número é uma sequência válida para um cartão
-- de crédito. Exemplos:
-- > luhn 1784
-- True
-- > luhn 4783
-- False
-- > luhn 4012888888881881
-- True
-- > luhn 4012888888881882
-- False



main :: IO ()
main = do
  putStrLn "hello world"
