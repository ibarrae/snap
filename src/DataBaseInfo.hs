module DataBaseInfo where

import Database.PostgreSQL.Simple
import LoadEnv
import System.Environment
import Data.Word

connInfo :: IO ConnectInfo
connInfo = do
  loadEnv
  h <- lookupEnv "HOST"
  p <- lookupEnv "PORT"
  u <- lookupEnv "USER"
  pass <- lookupEnv "PASS"
  db <- lookupEnv "DB"
  return $ 
    case ConnectInfo 
         <$> h 
         <*> (read @Word16 <$> p)
         <*> u 
         <*> pass 
         <*> db of
      Just ci -> ci
      _       -> error "Could not load connection info"