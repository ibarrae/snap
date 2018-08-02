module UserPresenterSpec where

import Test.Hspec
import Data.Time.Calendar
import User.Types
import User.Presenters

spec :: Spec 
spec = do
  describe "toUserPresenter" $
    context "when evaluating a User" $
      it "responds with a UserPresenter" $
        toUserPresenter
          (User 1 "Esteban" "foo@foo.com" 
            (ModifiedJulianDay 1) "123" Male (Currency 1000))
            `shouldBe`
          UserPresenter "Esteban" "foo@foo.com" 
            "1858-11-18" "1000.00" "1"
  describe "fromUserForm" $ 
    context "when evaluating a UserForm and an Int" $
      it "responds with a User" $
        fromUserForm
          (UserForm "Esteban" "foo@foo.com" 
            (ModifiedJulianDay 1) "123" Male (Currency 1000))
          1
        `shouldBe`
        User 1 "Esteban" "foo@foo.com" 
            (ModifiedJulianDay 1) "123" Male (Currency 1000)