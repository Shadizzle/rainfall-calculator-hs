{-# LANGUAGE ParallelListComp #-}

import System.Environment (getArgs)

select :: (a -> Bool) -> (a -> b) -> (a -> b) -> a -> b
select p t f x = if p x then t x else f x

average :: (Fractional a) => [a] -> a
average xs = sum xs / fromIntegral (length xs)

main = do
  args <- getArgs
  rain <- return $ map (normalize . read) args
  putStr $ concat [ list ++ " -> " ++ "Avg: " ++ avg ++ ", "
                                   ++ "Max: " ++ max ++ ", "
                                   ++ "Min: " ++ min ++ "\n"
                  | list <- args
                  | avg  <- map (maybe "N/A" (show . average)) rain
                  | max  <- map (maybe "N/A" (show . maximum)) rain
                  | min  <- map (maybe "N/A" (show . minimum)) rain]
  where
    normalize = select null (const Nothing) Just
              . filter (>= 0)
              . takeWhile (/= (-999))
