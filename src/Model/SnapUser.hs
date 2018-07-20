module Model.SnapUser where
  
import Data.Time.Calendar
import Snap.Snaplet.PostgresqlSimple

data SnapUser = SnapUser
  { id :: Int
  , name :: String
  , email :: String
  , birthDate :: Day
  , password :: String
  , genre :: String
  , income :: Double
  }

instance FromRow SnapUser where
  fromRow = SnapUser 
    <$> field 
    <*> field 
    <*> field 
    <*> field 
    <*> field 
    <*> field 
    <*> field

instance ToRow SnapUser where
  toRow (SnapUser key n e bd pass g i) = 
    toRow (key, n, e, bd, pass, g, i)