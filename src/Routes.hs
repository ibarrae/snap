module Routes where

import Data.ByteString
import Snap.Snaplet.Heist
import Application
import User.Handlers

routes :: [(ByteString,AppHandler)]
routes = [ ("/", welcomePage)
         , ("/users", handleUsers)
         , ("/users/add", handleUserAdd)]

welcomePage :: AppHandler
welcomePage = render "welcome"