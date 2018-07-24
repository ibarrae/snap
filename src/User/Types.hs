{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE TypeSynonymInstances #-}
module User.Types where

import Data.Time.Calendar
import Snap.Snaplet.PostgresqlSimple
import Database.PostgreSQL.Simple.ToField
import Database.PostgreSQL.Simple.FromField
import qualified Data.ByteString.Char8 as B
import Web.PathPieces
import qualified Data.Text as T
import Text.Read
import Text.Printf

newtype Currency 
  = Currency 
  { unCurrency :: Double } 
  deriving (Show,Eq)

instance ToField Currency where
  toField = toField . unCurrency

instance FromField Currency where
  fromField _ md = return $ Currency $
    case md of
      Just d -> read $ B.unpack d :: Double
      _      -> 0

instance PathPiece Currency where
  fromPathPiece = fmap Currency . readMaybe @Double . T.unpack
  toPathPiece = T.pack . printf "%.2f" . unCurrency

data User = User
  { userKey       :: Int
  , userName      :: String
  , userEmail     :: String
  , userBirthDate :: Day
  , userPassword  :: String
  , userGender    :: Gender
  , userIncome    :: Currency}

data Gender 
  = Male
  | Female
  | Other
  deriving (Show,Eq)

instance ToField Gender where
  toField = toField . show

instance FromField Gender where
  fromField _ md = return $ 
    case md of
      Just "Male"   -> Male
      Just "Female" -> Female
      _             -> Other

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

data UserPresenter
  = UserPresenter
  { upName     :: String
  , upMail     :: String
  , upBirthday :: String
  , upIncome   :: String}
  deriving (Show,Eq)