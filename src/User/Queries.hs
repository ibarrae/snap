module User.Queries where

import Database.PostgreSQL.Simple.SqlQQ
import Snap.Snaplet.PostgresqlSimple

allUsersQuery :: Query
allUsersQuery = 
  [sql| 
    SELECT *
    FROM snap_user 
  |]

insertUserQuery :: Query
insertUserQuery =
  [sql|
    INSERT INTO snap_user
    (name, email, birth_date, password, gender, income)
    VALUES 
    (?, ?, ?, ?, ?, ?)
  |]

deleteUserQuery :: Query
deleteUserQuery =
  [sql|
    DELETE FROM snap_user 
    WHERE id = ?
  |]