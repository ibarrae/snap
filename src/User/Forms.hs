module User.Forms where

import Data.Text hiding(map)
import Data.Time.Calendar
import Control.Arrow
import Text.Digestive.Form.Internal
import Text.Digestive.Form
import User.Types
import User.Validations
import User.ErrorMessages

userForm :: (Monad m) => Day -> Form Text m UserForm
userForm d = UserForm
  <$> textInput "name" invalidName validName
  <*> textInput "email" invalidEmail validEmail
  <*> dayInput
  <*> passwordInput
  <*> genderInput
  <*> incomeInput
  where dayInput = 
          "birthday" .: check invalidBirthday 
          (validBirthday d) (dateFormlet "%0Y-%m-%d" Nothing)
        passwordInput = 
          "pass_conf" .: validate matchesConfirmation passwordForm
        genderInput = "gender" .: choice mkChoice Nothing
        incomeInput = "income" .: validate validIncome (text $ Just "0.00")

passwordForm :: (Monad m) => Form Text m PasswordForm
passwordForm = PasswordForm
  <$> textInput "password" invalidPassword validPassword
  <*> "passwordConfirmation" .: text Nothing

textInput :: (Monad m) => Text -> Text -> (Text -> Bool) -> Form Text m Text
textInput tag errorMsg f = tag .: check errorMsg f (text Nothing)

mkChoice :: (Enum a, Show a) =>[(a,Text)]
mkChoice = map (id &&& pack . show) (enumFrom $ toEnum 0)