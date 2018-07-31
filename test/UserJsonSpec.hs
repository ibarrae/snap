module UserJsonSpec where

import Data.Time.Calendar
import Test.Hspec
import Data.Aeson
import User.Types

spec :: Spec
spec =
  describe "ToJSON and FromJSON instance of User" $
    context "when encoding, then decoding that result" $
      it "returns the same User" $
        let u = User 1 "esteban" "1@1.com" (ModifiedJulianDay 1) "esteban" Male (Currency 100.00)
        in decode (encode u) `shouldBe` Just u