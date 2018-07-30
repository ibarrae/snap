module User.Splices where

import Heist.Interpreted
import Data.Text
import Heist.Internal.Types
import Data.Map.Syntax
import User.Types

type UserSplice s 
  = Splices (Splice s)

userSplices :: (Monad s) => [UserPresenter] -> UserSplice s
userSplices u = "users" ## mapSplices (runChildrenWith . userPresenterSplice) u

userPresenterSplice :: (Monad s) => UserPresenter -> UserSplice s
userPresenterSplice UserPresenter{..} = do
  generateSplice "name" upName
  generateSplice "mail" upMail
  generateSplice "bd" upBirthday
  generateSplice "income" upIncome
  generateSplice "id" upId
  where 
    generateSplice b v = b ## textSplice $ pack v