module User.Persistence where

import Database.PostgreSQL.Simple.ToRow
import Snap.Snaplet.PostgresqlSimple
import Data.Int
import User.Queries
import User.Types

selectAllUsers :: (HasPostgres m) => m [User]
selectAllUsers = query_ allUsersQuery

insertUser :: (HasPostgres m) => UserForm -> m Int64
insertUser = execute insertUserQuery

deleteUser :: (HasPostgres m) => Int -> m Int64
deleteUser key = execute deleteUserQuery $ toRow [key]