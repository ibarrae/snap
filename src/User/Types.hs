{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE RecordWildCards, TypeSynonymInstances, FlexibleInstances, OverloadedStrings #-}
module User.Types where

import Data.Time.Calendar
import Snap.Snaplet.PostgresqlSimple
import Database.PostgreSQL.Simple.ToField
import Database.PostgreSQL.Simple.FromField

data User = User
  { userKey       :: Int
  , userName      :: String
  , userEmail     :: String
  , userBirthDate :: Day
  , userPassword  :: String
  , userGender    :: Gender
  , userIncome    :: Double}

data Gender 
  = Male
  | Female
  | Other
  deriving (Show,Eq,Read)

instance ToField Gender where
  toField = toField . show

instance FromField Gender where
  fromField _ d = do
    let readGender (Just "Male")   = return Male
        readGender (Just "Female") = return Female
        readGender _               = return Other
    readGender d

instance FromRow User where
  fromRow = User 
    <$> field 
    <*> field 
    <*> field 
    <*> field 
    <*> field 
    <*> field 
    <*> field

instance ToRow User where
  toRow User{..} = 
    [ toField userKey
    , toField userName
    , toField userEmail
    , toField userBirthDate
    , toField userPassword
    , toField userGender
    , toField userIncome]