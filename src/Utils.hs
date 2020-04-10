module Utils
    ( uppercase
    , removeSlash
    , removeNumber
    , objectToTupleList
    )
where

import qualified Data.Char                      ( toUpper )
import qualified Data.List.Split
import qualified Data.HashMap.Strict
import           Data.Aeson

uppercase :: String -> String
uppercase = map Data.Char.toUpper

removeSlash :: String -> String
removeSlash ('\"' : c : rest) = c : removeSlash rest
removeSlash ('\"'     : rest) = removeSlash rest
removeSlash (c        : rest) = c : removeSlash rest
removeSlash []                = []

removeNumber :: String -> String
removeNumber x = removeWords x ["Number"]

removeWords :: String -> [String] -> String
removeWords list1 words =
    init
        . concatMap (++ " ")
        . filter (not . (`elem` words))
        . Data.List.Split.splitOn " "
        $ list1


objectToTupleList :: Object -> [(String, String)]
objectToTupleList r = zip (map show (Data.HashMap.Strict.keys r))
                          (map show (Data.HashMap.Strict.elems r))
