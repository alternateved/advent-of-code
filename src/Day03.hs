module Day03 where

import           Data.Char (digitToInt)
import           Data.List (foldl', group, sort, transpose)

binaryToDec :: String -> Int
binaryToDec = foldl' convert 0
  where
    convert acc x = acc * 2 + digitToInt x

countChar :: Char -> String -> Int
countChar c = foldl' (\acc curr -> if curr == c then acc + 1 else acc) 0

analyseBit :: (Int -> Int -> Bool) -> String -> Char
analyseBit c l = if c zeros ones then '0' else '1'
  where
    zeros = countChar '0' l
    ones = countChar '1' l

calculateResult :: [String] -> Int
calculateResult l = binaryToDec gamma * binaryToDec epsilon
  where
    l' = transpose l
    gamma = map (analyseBit (<=)) l'
    epsilon = map (analyseBit (>=)) l'

parseBits :: String -> String
parseBits = show . calculateResult . lines

partOne :: IO ()
partOne = do
  input <- readFile "input_3"
  putStrLn $ parseBits input

findRating :: (Int -> Int -> Bool) -> [String] -> String
findRating c l = head $ go 0 [] l
  where
    l' = transpose l
    go _ acc [] = acc
    go i acc (x : xs) =
      if (x !! i) == analyseBit c (l' !! i)
        then go i (x:acc) xs
        else go (i + 1) acc xs

findCO2ScrubberRating :: [String] -> String
findCO2ScrubberRating = undefined

calculateResult' :: [String] -> Int
calculateResult' l = binaryToDec o2Rating * binaryToDec co2Rating
  where
    o2Rating = findRating (>=) l
    co2Rating = findRating (<=) l

parseBits' :: String -> String
parseBits' = show . calculateResult' . lines

partTwo :: IO ()
partTwo = do
  input <- readFile "input_3"
  putStrLn $ parseBits' input

test =
  unlines
    [ "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]

-- 010
test2 =
    [ "010",
      "110",
      "010"
    ]

-- 000
test3 =
    [ "000",
      "000",
      "000"
    ]

-- 110
test4 =
    [ "110",
      "110",
      "010"
    ]

-- 110
test5 =
    [ "110",
      "110",
      "110",
      "111"
    ]
