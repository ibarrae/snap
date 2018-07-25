module Main where

import Snap
import Site
import EnvRead

main :: IO ()
main = do
  ci <- loadConnInfoFromEnv
  serveSnaplet defaultConfig $ appInit ci