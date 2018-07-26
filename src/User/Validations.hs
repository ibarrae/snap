module User.Validations where

import Data.Text as T
import Data.Text.Encoding as TE
import Data.ByteString as B
import Data.Time.Calendar
import Text.Read
import Data.Bool
import Text.Digestive.Types
import Text.Email.Validate
import User.Types
import User.ErrorMessages

validName :: T.Text -> Bool
validName = validateLength 2 20

validPassword :: Maybe ByteString -> T.Text -> Bool
validPassword Nothing _ = False
validPassword (Just b) t =
  validateLength 6 20 t && TE.decodeUtf8 b == t

validateLength :: Int -> Int -> T.Text -> Bool
validateLength minL maxL t =
  let l = T.length t
  in l >= minL && l <= maxL

validEmail :: Text -> Bool
validEmail = isValid . TE.encodeUtf8

validBirthday :: Day -> Day -> Bool
validBirthday sd d = diffDays sd d `div` 365 <= 100

validIncome :: Text -> Result Text Currency
validIncome t = 
  let mc = readMaybe . T.unpack
      e = Error invalidIncome
      validAmount i = bool e (Success $ Currency i) (i>0)
  in maybe e validAmount $ mc t