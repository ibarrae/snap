module User.Handlers where

import Data.ByteString.Char8 hiding(map)
import Safe as S
import Control.Monad.IO.Class
import Data.Bool
import qualified Data.ByteString.Char8 as BS
import Data.Aeson
import Snap.Snaplet
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
  key <- getUserKeyFromQueryString
  user <- getUserFromDatabase key
  currentDay <- liftIO getSystemDay
  (view, muf) <- runForm "user_form" $ userForm currentDay
  maybe (handleForm user view) (renderSuccess key) muf
  where 
    getUserKeyFromQueryString = do
      mId <- getParam "id"
      let badRequest = finishResponse 400 "Parameter 'id' was not found."
      maybe badRequest (return . read . unpack) mId
    getUserFromDatabase key = do
      mUser <- S.headMay <$> selectUserById key
      let userNotFound = finishResponse 404 "User was not found."
      maybe userNotFound return mUser
    renderSuccess key uf = 
      renderPage (userSplice (fromUserForm uf key)) "users_edit_successful"
    handleForm u v =
      renderPage (initialSplices u v) "users_edit"
    renderPage splices page =
      heistLocal (bindSplices splices) $ render page
    -- | Splices taken from digestive functors and the user data taken from the
    -- database.
    initialSplices user view = do
      userSplice user
      digestiveSplices view

handleUserPut :: AppHandler
handleUserPut = do
  user <- getUserFromRequestBody
  update user
  where 
    getUserFromRequestBody = do
      body <- readRequestBody 5000
      maybe malformedBody return $ decode body
      where malformedBody 
              = finishResponse 400 "Malformed request body"
    update u = do 
      updatedUserCount <- updateUser u
      writeBS $ bool "Did not update any user."
        "User updated successfully."
        (updatedUserCount>0)

finishResponse :: Int -> ByteString -> Handler App App a
finishResponse code msg = do
  modifyResponse $ setResponseCode code
  writeBS msg
  getResponse >>= finishWith

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