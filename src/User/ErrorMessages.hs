module User.ErrorMessages where

import Data.Text

invalidName :: Text
invalidName = "Not a valid name."

invalidEmail :: Text
invalidEmail = "Not a valid e-mail."

invalidPassword :: Text
invalidPassword = "Not a valid password."

doesNotMatchConfirmation :: Text
doesNotMatchConfirmation = "Password does not match confirmation."

invalidBirthday :: Text
invalidBirthday = "Not a valid birthday."

invalidIncome :: Text
invalidIncome = "Not a valid income."