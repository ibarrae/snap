{-# OPTIONS_GHC -fno-warn-orphans #-}
module UserValidationsSpec where

import Test.Hspec
import Data.Time.Calendar
import Control.Monad.IO.Class
import Data.Text
import Text.Digestive.Types
import IoInteractions
import User.Validations
import User.Types
import User.ErrorMessages


instance Eq (Result Text Currency) where
  (Success c1) == (Success c2) = unCurrency c1 == unCurrency c2
  (Error e1) == (Error e2) = e1 == e2
  _ == _ = False

spec :: Spec 
spec = do
  describe "validName" $ do
    context "when evaluating a valid name" $
      it "returns true" $
        validName "esteban" `shouldBe` True
    context "when evaluating an invalid name" $
      it "returns false" $ do
        validName "" `shouldBe` False
        validName "1" `shouldBe` False
        validName "123456789012345678901" `shouldBe` False
  describe "validEmail" $ do
    context "when evaluating a valid email" $
      it "returns true" $
        validEmail "1@1.com" `shouldBe` True
    context "when evaluating an invalid email" $
      it "returns false" $ do
        validEmail "" `shouldBe` False
        validEmail "123.test" `shouldBe` False
  describe "validPassword" $ do
    context "when evaluating a valid password" $
      it "returns true" $
        validPassword (Just "esteban") "esteban" `shouldBe` True
    context "when evaluating an invalid password" $
      it "returns false" $ do
        validPassword Nothing "" `shouldBe` False
        validPassword Nothing "esteban" `shouldBe` False
        validPassword (Just "holaMundo") "esteban" `shouldBe` False
  describe "validBirthday" $ do
    context "when evaluating a valid birthday" $
      it "returns true" $ do
        sd <- liftIO getSystemDay
        validBirthday sd (read "1992-01-01" :: Day) `shouldBe` True
    context "when evaluatiing an invalid birthday" $
      it "returns false" $ do
        sd <- liftIO getSystemDay
        validBirthday sd (read "1900-01-01" :: Day) `shouldBe` False
  describe "validIncome" $ do
    context "when evaluationg a valid income" $
      it "returns Success Currency val" $
        validIncome "100.00" `shouldBe` Success (Currency 100.00)
    context "when evaluationg an invalid income" $
      it "returns Error 'Not a valid income.'" $ do
        validIncome "0" `shouldBe` Error invalidIncome
        validIncome "-1" `shouldBe` Error invalidIncome