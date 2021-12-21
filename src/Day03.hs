module Day03 where

import           Data.Char (digitToInt)
import           Data.List (foldl', group, sort)

binaryToDec :: String -> Int
binaryToDec = foldl' convert 0
  where
    convert acc x = acc * 2 + digitToInt x

countZeros :: (Ord a) => [a] -> Int
countZeros = length . head . group . sort

allPositions l = map (!! 0) l ++ map (!! 1) l ++ map (!! 2) l

result :: [String] -> String
result = undefined

parseBits :: String -> String
parseBits = result . lines

partOne :: IO ()
partOne = do
  input <- readFile "input_3"
  putStrLn $ parseBits input
