module Main where

import Snap
import Site
import IoInteractions

main :: IO ()
main = do
  ci <- loadConnInfoFromEnv
  serveSnaplet defaultConfig $ appInit ci