module User.Handlers where

import Control.Monad.IO.Class
import Data.Bool
import Snap.Snaplet.Heist
import Snap.Core
import Text.Digestive.Snap
import Text.Digestive.Heist
import Application
import User.Persistence
import User.Splices
import User.Presenters
import User.Forms
import Utils.Web
import Utils.Database
import IoInteractions

handleUsers :: AppHandler
handleUsers = do
  users <- selectAllRecords
  renderWithSplices "users" $ usersSplices $ map toUserPresenter users

handleUserAdd :: AppHandler
handleUserAdd = do
  currentDay <- liftIO getSystemDay
  (view, muf) <- runForm "user_form" $ userForm currentDay
  maybe (handleFormErrors view) insertUserIntoDb muf
  where 
    insertUserIntoDb uf = do 
      createdUsers <- insertUser uf
      bool userNotCreated (redirect "/users") (createdUsers>0)
    userNotCreated = 
      finishResponse 500 "Something went wrong while creating the user"
    handleFormErrors view =
      heistLocal (bindDigestiveSplices view) $ render "users_add" 

handleUserEdit :: AppHandler
handleUserEdit = do
  key <- getParameterFromQueryString "id"
  user <- getRecordFromDatabase key
  currentDay <- liftIO getSystemDay
  (view, muf) <- runForm "user_form" $ userForm currentDay
  maybe (handleForm user view) (renderSuccess key) muf
  where
    renderSuccess key uf = 
      updatePageWithSplices (userSplice (fromUserForm uf key)) "users_edit_successful"
    handleForm u v =
      updatePageWithSplices (initialSplices u v) "users_edit"
    -- | Splices taken from digestive functors and the user data taken from the
    -- database.
    initialSplices user view = do
      userSplice user
      digestiveSplices view

handleUserPut :: AppHandler
handleUserPut = do
  user <- fromRequestBody
  update user
  where
    update u = do 
      updatedUserCount <- updateUser u
      writeBS $ bool "Did not update any user."
        "User updated successfully."
        (updatedUserCount>0)

handleUserDelete :: AppHandler
handleUserDelete = do
  key <- getParameterFromQueryString "id"
  numDeletedUsers <- deleteUser key
  writeBS $ bool 
    "Something went wrong while deleting the user."
    "Correctly deleted" 
    (numDeletedUsers>0)