module Main where

countMeasurments :: [Int] -> Int
countMeasurments = go 0
  where
    go acc [] = acc
    go acc [_] = acc
    go acc (x:y:xs) = if y > x
                         then go (acc + 1) (y:xs)
                         else go acc (y:xs)

slideWindow :: [Int] -> [Int]
slideWindow = go []
  where
    go _ [] = []
    go acc [x] = acc
    go acc [x, y] = acc
    go acc (x:y:z:xs) = go (acc ++ [x + y + z]) (y:z:xs)

run :: String -> String
run = show . countMeasurments . slideWindow . map read . lines

main :: IO ()
main = do
  input <- readFile "input_1"
  putStrLn $ run input
