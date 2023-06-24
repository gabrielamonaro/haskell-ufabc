module Main (main) where

data [] a = [] | a : [a]



main :: IO ()
main = do
  putStrLn "hello world"
