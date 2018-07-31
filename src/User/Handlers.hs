module User.Handlers where

import Control.Monad.IO.Class
import Data.Bool
import qualified Data.ByteString.Char8 as BS
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
  sd <- liftIO getSystemDay
  (view, muf) <- runForm "user_form" $ userForm sd
  case muf of
    Just uf -> do
      numInsertedUsers <- insertUser uf
      bool (logError "Something went wrong while adding the user.") 
        (redirect "/users") (numInsertedUsers>0)
    Nothing -> heistLocal (bindDigestiveSplices view) $ render "users_add" 

handleUserDelete :: AppHandler
handleUserDelete = do
  mkey <- getParam "id"
  numDeletedUsers <- deleteUser 
        (maybe 
          (error "Could not parse id parameter")
          (read . BS.unpack) 
          mkey)
  bool (logError "Something went wrong while deleting the user.") 
    (writeBS "Correctly deleted") (numDeletedUsers>0)