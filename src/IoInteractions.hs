module IoInteractions where

import Data.Word
import Data.Time.Clock
import Data.Time.Calendar
import LoadEnv
import System.Environment
import Database

loadConnInfoFromEnv :: IO ConnInfo
loadConnInfoFromEnv = do
  loadEnv
  ConnInfo
    <$> fromEnv "HOST"
    <*> (read @Word16 <$> fromEnv "PORT")
    <*> fromEnv "USER"
    <*> fromEnv "PASS"
    <*> fromEnv "DB"

fromEnv :: String -> IO String
fromEnv tag = do
  v <- lookupEnv tag
  maybe (error $ msg tag) return v
  where msg t = "Could not load var: " ++ t

getSystemDay :: IO Day
getSystemDay = utctDay <$> getCurrentTime