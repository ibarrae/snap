module User.ErrorMessages where

import Data.Text

invalidName :: Text
invalidName = "Not a valid name."

invalidEmail :: Text
invalidEmail = "Not a valid e-mail."

invalidPassword :: Text
invalidPassword = "Not a valid password or does not match with confirmation."

invalidBirthday :: Text
invalidBirthday = "Not a valid birthday."

invalidIncome :: Text
invalidIncome = "Not a valid income."