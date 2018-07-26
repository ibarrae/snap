module User.Handlers where

import Control.Monad.IO.Class
import Snap.Snaplet.Heist
import Snap.Core
import Text.Digestive.Snap
import Text.Digestive.Heist
import Application
import User.Persistence
import User.Splices
import User.Presenters
import User.Forms
import IoInteractions

handleUsers :: AppHandler
handleUsers = do
  users <- selectAllUsers
  renderWithSplices "users" $ userSplices $ map toUserPresenter users

handleUserAdd :: AppHandler
handleUserAdd = do
  mpc <- getPostParam "user_form.passConf"
  sd <- liftIO getSystemDay
  (view, muf) <- runForm "user_form" $ userForm mpc sd
  case muf of
    Just uf -> insertUser uf >> redirect "/users"
    Nothing -> heistLocal (bindDigestiveSplices view) $ render "users_add" 