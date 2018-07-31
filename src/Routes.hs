module Routes where

import Data.ByteString
import Snap.Core
import Snap.Snaplet.Heist
import Snap.Util.FileServe
import Application
import User.Handlers

routes :: [(ByteString,AppHandler)]
routes = [ ("/",               welcomePage)
         , ("/users",          method GET handleUsers)
         , ("/users/add",      handleUserAdd)
         , ("/users/edit/:id", handleUserEdit)
         , ("/users/put",      method PUT handleUserPut)
         , ("static",          serveDirectory "static")]

welcomePage :: AppHandler
welcomePage = render "welcome"