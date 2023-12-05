module Day02 where

import Data.List (foldl')

newtype Move = Move (String, Int)
  deriving (Eq, Show)

newtype Position = Position (Int, Int)
  deriving (Eq, Show)

calculateResult :: Position -> Int
calculateResult (Position (x, y)) = x * y

performMove :: Position -> Move -> Position
performMove (Position (x, y)) (Move ("forward", d)) = Position (x + d, y)
performMove (Position (x, y)) (Move ("down", d)) = Position (x, y + d)
performMove (Position (x, y)) (Move ("up", d)) = Position (x, y - d)
performMove _ _ = Position (0, 0)

parseMove :: String -> Move
parseMove s = Move (direction, depth)
 where
  direction = head s'
  depth = read $ last s'
  s' = words s

performDive :: String -> String
performDive = show . calculateResult . foldl' performMove (Position (0, 0)) . map parseMove . lines

partOne :: IO ()
partOne = do
  input <- readFile "input2"
  putStrLn $ performDive input

newtype Position' = Position' (Int, Int, Int)
  deriving (Eq, Show)

calculateResult' :: Position' -> Int
calculateResult' (Position' (x, y, _)) = x * y

performMove' :: Position' -> Move -> Position'
performMove' (Position' (x, y, z)) (Move ("forward", d)) = Position' (x + d, y + (z * d), z)
performMove' (Position' (x, y, z)) (Move ("down", d)) = Position' (x, y, z + d)
performMove' (Position' (x, y, z)) (Move ("up", d)) = Position' (x, y, z - d)
performMove' _ _ = Position' (0, 0, 0)

performDive' :: String -> String
performDive' = show . calculateResult' . foldl' performMove' (Position' (0, 0, 0)) . map parseMove . lines

partTwo :: IO ()
partTwo = do
  input <- readFile "input2"
  putStrLn $ performDive' input
