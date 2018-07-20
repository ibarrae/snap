{-# LANGUAGE TemplateHaskell, FlexibleInstances #-}
module Application where

import Control.Lens
import Snap.Snaplet
import Snap.Snaplet.Heist
import Snap.Snaplet.Persistent
  
data App = App
        { _heist :: Snaplet (Heist App)
        , _db :: Snaplet PersistState 
        }

makeLenses ''App

instance HasHeist App where
  heistLens = subSnaplet heist

instance HasPersistPool (Handler a App) where
  getPersistPool = with db getPersistPool