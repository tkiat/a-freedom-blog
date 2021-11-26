module Test.Main where

import App.Theme (Theme(..), stringToTheme, toggleTheme)
import App.Utils (capitalize)
import Data.Array.NonEmpty.Internal (NonEmptyArray(..))
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Prelude
import Test.QuickCheck
import Test.QuickCheck.Arbitrary
import Test.QuickCheck.Gen

newtype Theme' = Theme' Theme
instance arbTheme' :: Arbitrary Theme' where
  arbitrary = elements $ NonEmptyArray $ [Theme' Day, Theme' Dark]

main :: Effect Unit
main = do
  quickCheck \(Theme' x) -> x /== toggleTheme x
  quickCheck \(Theme' x) -> case stringToTheme (show x) of
    Just y -> y === x
    Nothing -> Failed "stringToTheme (show x) should be Just x"
  quickCheck \x -> "A" <> x === capitalize ("a" <> x)
