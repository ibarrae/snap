module SiteSpec where

import Test.Hspec
import Snap.Snaplet.Test as T
import Snap.Test
import Data.Map as M hiding (delete)
import Data.Either.Unwrap as U
import Snap.Internal.Http.Types
import Site
import User.Handlers
import IoInteractions

spec :: Spec
spec =
  describe "requests" $ do
    context "when requesting /users" $
      it "should respond with status 200" $ do
        ci <- loadConnInfoFromEnv
        er <- T.runHandler Nothing (get "/users" M.empty) handleUsers $ appInit ci
        let r = U.fromRight er
        rspStatus r `shouldBe` 200
    context "when requesting /users/add" $
      it "should respond with status 200" $ do
        ci <- loadConnInfoFromEnv
        er <- T.runHandler Nothing (get "/users/add" M.empty) handleUserAdd $ appInit ci
        let r = U.fromRight er
        rspStatus r `shouldBe` 200
    context "when requesting /users/delete/:id" $
      it "should respond with status 200" $ do
        ci <- loadConnInfoFromEnv
        er <- T.runHandler Nothing 
          (delete "/users/delete/id" $ M.fromList [("id", ["500"])]) 
          handleUserDelete $ appInit ci
        let r = U.fromRight er
        rspStatus r `shouldBe` 200