module Main (main) where


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
--se o ano não terminar em 00 e for divisível por 4 dizemos que ele é bissexto.
anos = [1588,1592..2020]
bissextos :: [Integer]
bissextos = anos

main :: IO ()
main = do
  putStrLn "hello world"
