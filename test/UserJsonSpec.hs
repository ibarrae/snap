module UserJsonSpec where

import Data.Time.Calendar
import Test.Hspec
import Data.Aeson
import User.Types

spec :: Spec
spec = do
  describe "ToJSON and FromJSON instance of User" $
    context "when encoding, then decoding that result" $
      it "returns the same User" $
        let u = User 1 "esteban" "1@1.com" (ModifiedJulianDay 1) "esteban" Male (Currency 100.00)
        in decode (encode u) `shouldBe` Just u
  describe "ToJSON and FromJSON instance of the Gender data type" $ do
    context "when encoding" $
      it "returns a String" $
        encode Male `shouldBe` "\"Male\""
    context "when decoding a string a valid string" $
      it "returns a Just Gender" $
        (decode "\"Male\"" :: Maybe Gender) `shouldBe` Just Male
    context "when decoding an invalid string" $
      it "returns Nothing" $
        (decode "\"g\":\"Male\"" :: Maybe Gender) `shouldBe` Nothing
    