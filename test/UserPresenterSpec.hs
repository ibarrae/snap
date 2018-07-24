module UserPresenterSpec where

import Test.Hspec
import Data.Time.Calendar
import User.Types
import User.Presenters

spec :: Spec 
spec =
  describe "toUserPresenter" $
    context "when evaluating a User" $
      it "responds with a UserPresenter" $
        toUserPresenter
          (User 1 "Esteban" "foo@foo.com" 
            (ModifiedJulianDay 1) "123" Male (Currency 1000))
            `shouldBe`
          UserPresenter "Esteban" "foo@foo.com" 
            "1858-11-18" "1000.00"