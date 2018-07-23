{-# LANGUAGE OverloadedStrings #-}
module User.Handler where

import qualified Heist.Interpreted as I  
import qualified Data.Text as T
import           Data.Map.Syntax ((##))
import           Snap.Snaplet.Heist
import           Application
import           User.Persistence
import           User.Types

handleUsers :: AppHandler
handleUsers = do
  users <- selectAllUsers
  renderWithSplices "users" $ userSplices users
  where
    userSplices u = "users" ## I.mapSplices (I.runChildrenWith . userSplice) u
    userSplice u = do
      "name" ## I.textSplice (T.pack $ userName u)
      "mail" ## I.textSplice (T.pack $ userEmail u)
      "bd" ## I.textSplice (T.pack (show $ userBirthDate u))