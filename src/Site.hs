{-# LANGUAGE OverloadedStrings #-}
module Site where

import Snap
import Snap.Snaplet.Heist
import Snap.Snaplet.PostgresqlSimple
import Data.ByteString

import Application
import User.Handler

appInit :: SnapletInit App App
appInit = makeSnaplet "snap" "SNAP Framework example" Nothing $ do
  hs <- nestSnaplet "heist" heist $ heistInit "templates"
  p <- nestSnaplet "db" db pgsInit
  addRoutes routes
  return $ App hs p

routes :: [(ByteString,AppHandler)]
routes = [ ("/", welcomePage)
         , ("/users", handleUsers)]

welcomePage :: AppHandler
welcomePage = render "welcome"