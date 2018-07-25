module Site where

import Snap
import Snap.Snaplet.Heist
import Application
import Routes
import Database

appInit :: ConnInfo -> SnapletInit App App
appInit c = makeSnaplet "snap" "SNAP Framework example" Nothing $ do
  hs <- nestSnaplet "heist" heist $ heistInit "templates"
  p <- nestSnaplet "db" db $ initDb c
  addRoutes routes
  return $ App hs p