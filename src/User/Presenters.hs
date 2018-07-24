module User.Presenters where

import Web.PathPieces  
import Data.Text
import User.Types

toUserPresenter :: User -> UserPresenter
toUserPresenter User{..} = 
  let bd = show userBirthDate
      income = unpack $ toPathPiece userIncome
  in UserPresenter userName userEmail bd income