module User.Persistence where

import Snap.Snaplet.PostgresqlSimple
import Data.Int
import User.Queries
import User.Types

selectAllUsers :: (HasPostgres m) => m [User]
selectAllUsers = query_ allUsersQuery

selectUserById :: (HasPostgres m) => Int -> m [User]
selectUserById key = query userByIdQuery [key]

insertUser :: (HasPostgres m) => UserForm -> m Int64
insertUser = execute insertUserQuery

updateUser :: (HasPostgres m) => User -> m Int64
updateUser User{..} = execute updateUserQuery 
  [ userName
  , userEmail
  , show userBirthDate
  , userPassword
  , show userGender
  , show $ unCurrency userIncome
  , show userKey]