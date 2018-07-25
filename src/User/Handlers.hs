module User.Handlers where

import Snap.Snaplet.Heist
import Application
import User.Persistence
import User.Splices
import User.Presenters

handleUsers :: AppHandler
handleUsers = do
  users <- selectAllUsers
  renderWithSplices "users" $ userSplices $ map toUserPresenter users