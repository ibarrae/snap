module User.Persistence where

import Snap.Snaplet.PostgresqlSimple
import User.Query
import User.Types

selectAllUsers :: (HasPostgres m) => m [User]
selectAllUsers = query_ allUsersQuery