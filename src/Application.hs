{-# LANGUAGE TemplateHaskell, FlexibleInstances #-}
module Application where

import Control.Lens
import Snap.Snaplet
import Snap.Snaplet.Heist
import Snap.Snaplet.PostgresqlSimple
import Control.Monad.Reader
import Control.Monad.State.Class

data App = App
        { _heist :: Snaplet (Heist App)
        , _db :: Snaplet Postgres
        }

makeLenses ''App

instance HasHeist App where
  heistLens = subSnaplet heist

instance HasPostgres (Handler b App) where
  getPostgresState = with db get
  setLocalPostgresState s = local (set (db . snapletValue) s)