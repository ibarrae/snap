module Routes where

import Data.ByteString
import Snap.Core
import Snap.Snaplet.Heist
import Snap.Util.FileServe
import Application
import User.Handlers

routes :: [(ByteString,AppHandler)]
routes = [ ("/",               method GET welcomePage)
         , ("/users",          method GET handleUsers)
         , ("/users/add",      methods [GET, POST] handleUserAdd)
         , ("/users/edit/:id", methods [GET, POST] handleUserEdit)
         , ("/users/put",      method PUT handleUserPut)
         , ("static",          serveDirectory "static")]

welcomePage :: AppHandler
welcomePage = render "welcome"