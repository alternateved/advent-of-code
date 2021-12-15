module Day01 where

countMeasurments :: [Int] -> Int
countMeasurments = go 0
  where
    go acc [] = acc
    go acc [_] = acc
    go acc (x:y:xs) = if y > x
                         then go (acc + 1) (y:xs)
                         else go acc (y:xs)

sweepOne :: String -> String
sweepOne = show . countMeasurments . map read . lines

partOne :: IO ()
partOne = do
  input <- readFile "input_1"
  putStrLn $ sweepOne input

slideWindow :: [Int] -> [Int]
slideWindow = go []
  where
    go _ []           = []
    go acc [x]        = acc
    go acc [x, y]     = acc
    go acc (x:y:z:xs) = go (acc ++ [x + y + z]) (y:z:xs)

sweepTwo :: String -> String
sweepTwo = show . countMeasurments . slideWindow . map read . lines

partTwo :: IO ()
partTwo = do
  input <- readFile "input_1"
  putStrLn $ sweepTwo input
