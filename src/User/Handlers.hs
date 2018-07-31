module User.Handlers where

import Data.ByteString.Char8 hiding(map, head, null)
import Data.Bool
import Control.Monad.IO.Class
import Data.Aeson
import Snap.Snaplet.Heist
import Snap.Core
import Heist.Interpreted
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
  renderWithSplices "users" $ usersSplices $ map toUserPresenter users

handleUserAdd :: AppHandler
handleUserAdd = do
  sd <- liftIO getSystemDay
  (view, muf) <- runForm "user_form" $ userForm sd
  case muf of
    Just uf -> insertUser uf >> redirect "/users"
    Nothing -> heistLocal (bindDigestiveSplices view) $ render "users_add" 

handleUserEdit :: AppHandler
handleUserEdit = do
  mId <- getParam "id"
  let key = maybe (error "Id parameter not found.")
          (read . unpack)
          mId
  users <- selectUserById key
  bool (handleReq (head users) key) userNotFound (null users) 
  where 
    userNotFound = writeBS "User not found."
    handleReq user userKey = do
      sd <- liftIO getSystemDay
      (view, muf) <- runForm "user_form" $ userForm sd
      case muf of
        Just uf -> renderSuccess uf userKey
        Nothing -> handleForm user view
    renderSuccess uf k = 
      renderPage (userSplice (toUserFromUserForm uf k)) "users_edit_successful"
    handleForm u v =
      renderPage (initialSplices u v) "users_edit"
    renderPage splices page =
      heistLocal (bindSplices splices) $ render page
    -- | Splices taken from digestive functors and the user data taken
    -- from the database.
    initialSplices user view = do
      userSplice user
      digestiveSplices view
        
handleUserPut :: AppHandler
handleUserPut = do
  body <- readRequestBody 5000
  logError $ pack (show body)
  maybe (error "Malformed request body") update (decode body)
  where update u = do
          updatedUserCount <- updateUser u
          bool (writeBS "Did not update any user.")
            (writeBS "User updated successfully.")
            (updatedUserCount>0)

