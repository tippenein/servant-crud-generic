module Servant.Crud.GenericSpec (spec) where

import Servant.Crud.Generic

import Test.Hspec

spec :: Spec
spec =
  describe "main" $ do
    it "returns the unit" $
      main `shouldReturn` ()
