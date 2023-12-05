module Day03 where

import Data.Char (digitToInt)
import Data.List (foldl', group, sort, transpose)

data Rarity = Common | Rare

binaryToDec :: String -> Int
binaryToDec = foldl' convert 0
 where
  convert acc x = acc * 2 + digitToInt x

countChar :: Char -> String -> Int
countChar c = foldl' (\acc curr -> if curr == c then acc + 1 else acc) 0

analyseBit :: Rarity -> String -> Char
analyseBit r l = case r of
  Common -> if ones >= zeros then '1' else '0'
  Rare -> if zeros <= ones then '0' else '1'
 where
  zeros = countChar '0' l
  ones = countChar '1' l

calculateResult :: [String] -> Int
calculateResult l = binaryToDec gamma * binaryToDec epsilon
 where
  l' = transpose l
  gamma = map (analyseBit Common) l'
  epsilon = map (analyseBit Rare) l'

parseBits :: String -> String
parseBits = show . calculateResult . lines

partOne :: IO ()
partOne = do
  input <- readFile "input3"
  putStrLn $ parseBits input

filterBits :: Rarity -> Int -> [String] -> [String]
filterBits r i l = filter byBit l
 where
  l' = transpose l
  byBit x = x !! i == analyseBit r (l' !! i)

findRating :: Rarity -> [String] -> String
findRating r l = head $ go 0 l
 where
  go acc [x] = [x]
  go acc xs = go (acc + 1) (filterBits r acc xs)

calculateResult' :: [String] -> Int
calculateResult' l = binaryToDec o2Rating * binaryToDec co2Rating
 where
  o2Rating = findRating Common l
  co2Rating = findRating Rare l

parseBits' :: String -> String
parseBits' = show . calculateResult' . lines

partTwo :: IO ()
partTwo = do
  input <- readFile "input3"
  putStrLn $ parseBits' input

test =
  [ "00100"
  , "11110"
  , "10110"
  , "10111"
  , "10101"
  , "01111"
  , "00111"
  , "11100"
  , "10000"
  , "11001"
  , "00010"
  , "01010"
  ]
