{-# LANGUAGE OverloadedStrings #-}
module Site where

import Snap
import Snap.Snaplet.Heist
import Snap.Snaplet.PostgresqlSimple

import Application

appInit :: SnapletInit App App
appInit = makeSnaplet "snap" "SNAP Framework example" Nothing $ do
  hs <- nestSnaplet "heist" heist $ heistInit "templates"
  p <- nestSnaplet "db" db pgsInit
  addRoutes [("/", welcomePage)]
  return $ App hs p

welcomePage :: (HasHeist b) => Handler b v ()
welcomePage = render "welcome"