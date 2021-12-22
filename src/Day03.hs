module Day03 where

import           Data.Char (digitToInt)
import           Data.List (foldl', group, sort, transpose)

binaryToDec :: String -> Int
binaryToDec = foldl' convert 0
  where
    convert acc x = acc * 2 + digitToInt x

negateBit :: Char -> Char
negateBit x = if x == '1' then '0' else '1'

analyseBit :: (Int -> Int -> Bool) -> String -> Char
analyseBit c l = if c zeros ones then '0' else '1'
  where
    l' = group . sort $ l
    zeros = length . head $ l'
    ones = length . last $ l'

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

-- analyseBit first index and decide if the list should be filtered by 0 or 1
-- analyseBit next index and decide if ... repeat until the end of the list
-- return result

findO2GeneratorRating :: [String] -> String
findO2GeneratorRating = undefined

findCO2ScrubberRating :: [String] -> String
findCO2ScrubberRating = undefined

calculateResult' :: [String] -> Int
calculateResult' l = binaryToDec o2Rating * binaryToDec co2Rating
  where
    o2Rating = findO2GeneratorRating l
    co2Rating = findCO2ScrubberRating l

parseBits' :: String -> String
parseBits' = show . calculateResult' . lines

partTwo :: IO ()
partTwo = do
  input <- readFile "input_3"
  putStrLn $ parseBits' input

test =
  unlines [
    "00100",
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
