module SiteSpec where

import Test.Hspec
import Snap.Snaplet.Test as T
import Snap.Test
import Data.Map as M
import Data.Either.Unwrap as U
import Snap.Internal.Http.Types
import Site
import User.Handlers

spec :: Spec
spec =
  describe "requests" $
    context "when requesting /users" $
      it "should respond with status 200" $ do
        er <- T.runHandler Nothing (get "/users" M.empty) handleUsers appInit
        let r = U.fromRight er
        rspStatus r `shouldBe` 200