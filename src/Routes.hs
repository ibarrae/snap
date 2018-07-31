module Routes where

import Data.ByteString
import Snap.Core
import Snap.Util.FileServe
import Snap.Snaplet.Heist
import Application
import User.Handlers

routes :: [(ByteString,AppHandler)]
routes = [ ("/users", method GET handleUsers)
         , ("/users/add", handleUserAdd)
         , ("/users/delete/:id", method DELETE handleUserDelete)
         , ("static", serveDirectory "static")]

welcomePage :: AppHandler
welcomePage = render "welcome"