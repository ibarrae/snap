module User.Splices where

import Heist.Interpreted
import Data.Text
import Heist.Internal.Types
import Data.Map.Syntax
import User.Types

type UserSplice s 
  = Splices (Splice s)

usersSplices :: (Monad s) => [UserPresenter] -> UserSplice s
usersSplices u = "users" ## mapSplices (runChildrenWith . userPresenterSplice) u

userPresenterSplice :: (Monad s) => UserPresenter -> UserSplice s
userPresenterSplice UserPresenter{..} = do
  generateSplice "name" upName
  generateSplice "mail" upMail
  generateSplice "bd" upBirthday
  generateSplice "income" upIncome
  generateSplice "id" upId
  
userSplice :: (Monad s) => User -> UserSplice s
userSplice User {..} = do
  generateSplice "key" (show userKey)
  generateSplice "name" userName
  generateSplice "email" userEmail
  generateSplice "birthday" (show userBirthDate)
  generateSplice "password" userPassword
  generateSplice "gender" (show userGender)
  generateSplice "income" (show $ unCurrency userIncome)

generateSplice :: (Monad s) => Text -> String -> UserSplice s
generateSplice tag value = tag ## textSplice $ pack value
