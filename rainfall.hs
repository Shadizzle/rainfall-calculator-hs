{-# LANGUAGE ParallelListComp #-}
import System.Environment (getArgs)

main = do
  args <- getArgs
  averages <- return $ map (averageRainfall . read) args
  putStr $ foldr (++) "" $ [ list ++ " -> " ++ (show avg) ++ "\n"
                           | list <- args
                           | avg  <- averages]
   where
     average xs = sum xs / fromIntegral (length xs)
     normalize = filter (>= 0) . takeWhile (/= (-999))
     averageRainfall = average . normalize
