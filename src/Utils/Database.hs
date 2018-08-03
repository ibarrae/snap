module Utils.Database where

import Database.PostgreSQL.Simple.ToField
import Snap.Snaplet.PostgresqlSimple
import User.Types
import User.Queries

class CommonSQL a where
  selectAllRecords :: (HasPostgres m) => m [a]
  selectByKey :: (HasPostgres m, ToField b) => b -> m [a]

instance CommonSQL User where
  selectAllRecords = query_ allUsersQuery
  selectByKey key = query userByIdQuery [key]