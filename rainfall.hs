{-# LANGUAGE ParallelListComp #-}

import System.Environment (getArgs)
import Data.Maybe (fromMaybe)

average :: (Fractional a) => [a] -> Maybe a
average [] = Nothing
average xs = Just $ sum xs / fromIntegral (length xs)

main = do
  args <- getArgs
  averages <- return $ map (averageRainfall . read) args
  putStr $ concat [ list ++ " -> " ++ avg ++ "\n"
                  | list <- args
                  | avg  <- averages]
   where
     averageRainfall = maybe "No Result" show
                     . average
                     . filter (>= 0)
                     . takeWhile (/= (-999))
