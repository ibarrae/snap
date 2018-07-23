{-# LANGUAGE QuasiQuotes #-}
module User.Query where

import Database.PostgreSQL.Simple.SqlQQ
import Snap.Snaplet.PostgresqlSimple

allUsersQuery :: Query
allUsersQuery = [sql| SELECT *
                       FROM snap_user |]