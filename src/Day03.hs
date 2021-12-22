module Day03 where

import           Data.Char (digitToInt)
import           Data.List (foldl', group, sort, transpose)

binaryToDec :: String -> Int
binaryToDec = foldl' convert 0
  where
    convert acc x = acc * 2 + digitToInt x

negateBit :: Char -> Char
negateBit x = if x == '1' then '0' else '1'

commonBit :: String -> Char
commonBit l = if zeros > ones then '0' else '1'
  where
    l' = group . sort $ l
    zeros = length . head $ l'
    ones = length . last $ l'

calculateResult :: [String] -> Int
calculateResult l = binaryToDec gamma * binaryToDec epsilon
  where
    gamma = map commonBit . transpose $ l
    epsilon = map negateBit gamma

parseBits :: String -> String
parseBits = show . calculateResult . lines

partOne :: IO ()
partOne = do
  input <- readFile "input_3"
  putStrLn $ parseBits input

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
