{-# LANGUAGE OverloadedStrings #-}
module Site where

import Snap
import Snap.Snaplet.Heist
import Snap.Snaplet.Persistent
import Database.Persist.Sql
import Snap.Snaplet.Auth.Backends.Persistent

import Application

appInit :: SnapletInit App App
appInit = makeSnaplet "snap" "SNAP Framework example" Nothing $ do
  hs <- nestSnaplet "heist" heist $ heistInit "templates"
  p <- nestSnaplet "" db $ initPersist (runMigration migrateAuth)
  addRoutes [("/", welcomePage)]
  return $ App hs p

welcomePage :: (HasHeist b) => Handler b v ()
welcomePage = render "welcome"