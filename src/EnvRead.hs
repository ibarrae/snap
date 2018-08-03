module EnvRead where

import LoadEnv
import System.Environment
import Database

loadConnInfoFromEnv :: IO ConnInfo
loadConnInfoFromEnv = do
  loadEnv
  ConnInfo
    <$> fromEnv "HOST"
    <*> (read <$> fromEnv "PORT")
    <*> fromEnv "USER"
    <*> fromEnv "PASS"
    <*> fromEnv "DB"

fromEnv :: String -> IO String
fromEnv tag = do
  v <- lookupEnv tag
  maybe (error $ msg tag) return v
  where msg = (++) "Could not load var: "