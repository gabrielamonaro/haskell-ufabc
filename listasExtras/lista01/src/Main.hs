module Main (main) where

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


main :: IO ()
main = do
  putStrLn "hello world"

