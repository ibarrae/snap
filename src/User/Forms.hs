module User.Forms where

import Data.ByteString
import Data.Text
import Data.Time.Calendar
import Text.Digestive.Form.Internal
import Text.Digestive.Form
import User.Types
import User.Validations
import User.ErrorMessages

userForm :: (Monad m) => Maybe ByteString -> Day -> Form Text m UserForm
userForm mb d = UserForm
  <$> textInput "name" invalidName validName
  <*> textInput "email" invalidEmail validEmail
  <*> dayInput
  <*> textInput "password" invalidPassword (validPassword mb)
  <*> genderInput
  <*> incomeInput
  where textInput t em f = t .: check em f (text Nothing)
        dayInput = 
          "bd" .: check invalidBirthday 
          (validBirthday d) (dateFormlet "%0Y-%m-%d" Nothing)
        genderInput = "gender" .: choice genderChoice Nothing
        incomeInput = "income" .: validate validIncome (text $ Just "0.00")

genderChoice :: [(Gender,Text)]
genderChoice = 
  [ (Male, "Male")
  , (Female, "Female")
  , (Other, "Other")]