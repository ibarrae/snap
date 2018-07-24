module Site where

import Snap
import Snap.Snaplet.Heist
import Snap.Snaplet.PostgresqlSimple
import Database.PostgreSQL.Simple
import Control.Monad.IO.Class
import Application
import Routes
import DataBaseInfo

appInit :: SnapletInit App App
appInit = makeSnaplet "snap" "SNAP Framework example" Nothing $ do
  hs <- nestSnaplet "heist" heist $ heistInit "templates"
  c <- liftIO connInfo
  p <- nestSnaplet "db" db $ pgsInit' $ (pgsDefaultConfig . postgreSQLConnectionString) c
  addRoutes routes
  return $ App hs p