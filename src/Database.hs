module Database where

import Database.PostgreSQL.Simple
import Data.Word
import Snap
import Snap.Snaplet.PostgresqlSimple

data ConnInfo 
  = ConnInfo 
  { connHost     :: String
  , connPort     :: Word16
  , connUser     :: String
  , connPassWord :: String
  , connDb       :: String}

initDb :: ConnInfo -> SnapletInit b Postgres
initDb = pgsInit' . pgsDefaultConfig . postgreSQLConnectionString . toConnectInfo

toConnectInfo :: ConnInfo -> ConnectInfo
toConnectInfo ConnInfo{..} =
  ConnectInfo connHost connPort connUser connPassWord connDb   