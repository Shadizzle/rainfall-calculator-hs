{-# LANGUAGE ParallelListComp #-}

import System.Environment (getArgs)
import Text.Read (readMaybe)
import Data.List (intercalate)
import qualified Data.Map.Strict as Map

average :: (Integral a, Fractional b) => [a] -> b
average xs = sum (fmap fromIntegral xs) / fromIntegral (length xs)

type Rain = [Int]
type ReportGenerator = Map.Map String (Rain -> ReportField)
newtype Report = Report (Map.Map String ReportField)
data ReportField = IntField Int
                 | FloatField Float
                 | StringField String
                 | EmptyField

instance Show Report where
  show (Report report) = intercalate ", " [ name ++ ": " ++ show field
                                          | (name, field) <- Map.toList report ]

instance Show ReportField where
  show (IntField i) = show i
  show (FloatField f) = show f
  show (StringField s) = s
  show EmptyField = "N/A"

normalize :: [Int] -> Rain
normalize = filter (>= 0)
          . takeWhile (/= (-999))

(|?|) :: (a -> ReportField) -> (Rain -> a) -> Rain -> ReportField
(|?|) fieldType transform rain = if null rain
                               then EmptyField
                               else (fieldType . transform) rain

reportsWith :: ReportGenerator -> Rain -> Report
reportsWith generator rain = Report (Map.map ($ rain) generator)

report :: Rain -> Report
report = reportsWith stdReport
  where stdReport = Map.fromList
                  [ ("Avg", FloatField |?| average)
                  , ("Max", IntField   |?| maximum)
                  , ("Min", IntField   |?| minimum)
                  ]

main = do
  args <- getArgs
  putStr $ concat [ list ++ " -> " ++ report ++ "\n"
                  | list <- args
                  | report <- runReports args ]
  where runReports = fmap ( maybe "Invalid Input" show
                          . fmap report
                          . fmap normalize
                          . readMaybe
                          )
