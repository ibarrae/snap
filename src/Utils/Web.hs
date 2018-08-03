module Utils.Web where

import Database.PostgreSQL.Simple.ToField
import Data.Aeson  
import Data.ByteString.Char8
import Heist.Internal.Types
import Safe as S
import Snap.Core
import Application (App, AppHandler)
import Snap.Snaplet
import Snap.Snaplet.Heist
import Heist.Interpreted
import Utils.Database

getParameterFromQueryString :: Read a => ByteString -> Handler App App a
getParameterFromQueryString param = do
  mParameter <- getParam param
  let msg = append "Parameter not found: " param
      badRequest = finishResponse 400 msg
  maybe badRequest (return . read . unpack) mParameter

fromRequestBody :: (FromJSON a) => Handler App App a
fromRequestBody = do
  body <- readRequestBody 5000
  maybe malformedBody return $ decode body
  where malformedBody 
          = finishResponse 400 "Malformed request body"

getRecordFromDatabase :: (CommonSQL a, ToField b) => b -> Handler App App a
getRecordFromDatabase key = do
  mRecord <- S.headMay <$> selectByKey key
  let userNotFound = finishResponse 404 "Record was not found."
  maybe userNotFound return mRecord

finishResponse :: Int -> ByteString -> Handler App App a
finishResponse code msg = do
  modifyResponse $ setResponseCode code
  writeBS msg
  getResponse >>= finishWith

updatePageWithSplices :: 
  Splices (Splice (Handler App App)) -> ByteString -> AppHandler
updatePageWithSplices splices page =
  heistLocal (bindSplices splices) $ render page