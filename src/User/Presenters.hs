module User.Presenters where

import Web.PathPieces  
import Data.Text
import User.Types

toUserPresenter :: User -> UserPresenter
toUserPresenter User{..} = 
  let bd = show userBirthDate
      income = unpack $ toPathPiece userIncome
      key = show userKey
  in UserPresenter userName userEmail bd income key

toUserFromUserForm :: UserForm -> Int -> User
toUserFromUserForm UserForm{..} key =
  User 
    key 
    (unpack ufName) 
    (unpack ufMail) 
    ufBirthday 
    (unpack ufPassword) 
    ufGender 
    ufIncome