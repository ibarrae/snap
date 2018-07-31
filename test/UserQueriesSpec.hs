{-# LANGUAGE ScopedTypeVariables #-}
module UserQueriesSpec where

import Data.Int
import Data.Time.Calendar
import Control.Monad.IO.Class
import Test.Hspec
import Test.Hspec.DB
import qualified Snap.Snaplet.PostgresqlSimple as PS
import Database.PostgreSQL.Simple.SqlQQ
import Database.PostgreSQL.Transact
import Database.PostgreSQL.Simple.Queue.Migrate
import Database.PostgreSQL.Simple.ToRow
import User.Queries
import User.Types

spec :: Spec
spec = 
  describeDB (migrate "test") "Users queries" $ do
    itDB "creating test table for users" $ 
      testCreateTable
    itDB "select all users query" $
      testUserSelect
    itDB "insert user" $
      testUserInsert
    itDB "delete user" $
      testUserDelete

testCreateTable :: forall m. (MonadIO m) => DBT m Int64
testCreateTable = execute_ createUserTable

createUserTable :: PS.Query
createUserTable = 
  [sql|
    CREATE TABLE snap_user (
    id SERIAL PRIMARY KEY,
    name text not null,
    email text not null,
    birth_date date not null,
    password text not null,
    gender text not null,
    income numeric not null
    );
  |]

testUserSelect :: forall m. (MonadIO m) => DBT m [User]
testUserSelect = query_ allUsersQuery :: DBT m [User]

testUserInsert :: forall m. (MonadIO m) => DBT m Int64
testUserInsert = execute insertUserQuery 
  (UserForm "test" "test@test.com" (ModifiedJulianDay 1) 
  "test" Male (Currency 100.00))

testUserDelete :: forall m. (MonadIO m) => DBT m Int64
testUserDelete = execute deleteUserQuery (toRow [1 :: Int])