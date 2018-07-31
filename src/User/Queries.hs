module User.Queries where

import Database.PostgreSQL.Simple.SqlQQ
import Snap.Snaplet.PostgresqlSimple

allUsersQuery :: Query
allUsersQuery = 
  [sql| 
    SELECT *
    FROM snap_user 
  |]

userByIdQuery :: Query
userByIdQuery = 
  [sql|
    SELECT *
    FROM snap_user
    WHERE id = ?
  |]

insertUserQuery :: Query
insertUserQuery =
  [sql|
    INSERT INTO snap_user
    (name, email, birth_date, password, gender, income)
    VALUES 
    (?, ?, ?, ?, ?, ?)
  |]

updateUserQuery :: Query
updateUserQuery =
  [sql|
    UPDATE snap_user
    set name = ?,
    email = ?,
    birth_date = ?,
    password = ?,
    gender = ?,
    income = ?
    WHERE id = ?
  |]