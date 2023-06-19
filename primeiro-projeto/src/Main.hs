module Main (main) where

square :: Int -> Int
square x = x * x

main :: IO ()
main = do
  putStrLn "hello world"
  print (square 6)
  print $ square 6  
