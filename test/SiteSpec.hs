module SiteSpec where

import Data.ByteString
import Test.Hspec
import Snap.Snaplet.Test as T
import Snap.Test
import Data.Map as M
import Data.Either.Unwrap
import Snap.Internal.Http.Types
import Site
import User.Handlers
import EnvRead

spec :: Spec
spec =
  describe "requests" $ do
    context "when requesting /users" $
      it "should respond with status 200" $ do
        ci <- loadConnInfoFromEnv
        er <- T.runHandler Nothing (get "/users" M.empty) handleUsers $ appInit ci
        let r = fromRight er
        rspStatus r `shouldBe` 200
    context "when requesting /users/add" $
      it "should respond with status 200" $ do
        ci <- loadConnInfoFromEnv
        er <- T.runHandler Nothing (get "/users/add" M.empty) handleUsers $ appInit ci
        let r = fromRight er
        rspStatus r `shouldBe` 200
    context "when requesting /users/edit/ without the id parameter" $
      it "should respond with status 400" $ do
        ci <- loadConnInfoFromEnv
        er <- T.runHandler Nothing (get "/users/edit/" M.empty) handleUserEdit $ appInit ci
        let r = fromRight er
        rspStatus r `shouldBe` 400
    context "when requesting /users/edit/:id for an invalid user key" $
      it "should respond with status 404" $ do
        ci <- loadConnInfoFromEnv
        let request =
              get "/users/edit/" $ M.fromList [("id", ["-1"])]
        er <- T.runHandler Nothing request handleUserEdit $ appInit ci
        let r = fromRight er
        rspStatus r `shouldBe` 404
    context "when requesting /users/put without a request body" $
      it "should respond with status 400" $ do
        ci <- loadConnInfoFromEnv
        let request = put "/users/put" "application/json" ""
        er <- T.runHandler Nothing request handleUserPut $ appInit ci
        let r = fromRight er
        rspStatus r `shouldBe` 400
    context "when requesting /users/put a valid request body" $
      it "should respond with status 200" $ do
        ci <- loadConnInfoFromEnv
        let reqBody = append
              "{\"key\":11,\"name\":\"jaime ibarra\",\"email\":\"2@2.com\",\"birthday\":\"1990-12-02\","
              "\"password\":\"ibarra\",\"gender\":\"Male\",\"income\":1250}"
            request = put "/users/put" "application/json" reqBody
        er <- T.runHandler Nothing request handleUserPut $ appInit ci
        let r = fromRight er
        rspStatus r `shouldBe` 200