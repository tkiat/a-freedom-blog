module App.Utils where

import Affjax as A
import Affjax.ResponseFormat as ResponseFormat
import Affjax.StatusCode (StatusCode(..))
import Data.CodePoint.Unicode (toUpperSimple)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), Replacement(..), replaceAll)
import Data.String.CodePoints (uncons)
import Data.String.Common (toLower)
import Data.String.NonEmpty (toString)
import Data.String.NonEmpty.CodePoints (cons)
import Prelude
import React.Basic.Hooks.Aff (UseAff, useAff)
import React.Basic.Hooks.Internal (Hook)

asyncFetch :: forall a.
  ResponseFormat.ResponseFormat a ->
  String ->
  Hook (UseAff Unit (Either String a)) (Maybe (Either String a))
asyncFetch format url = useAff unit do
  A.get format url >>= case _ of
    Right r
      | r.status == StatusCode 200 -> pure $ Right r.body
      | otherwise -> pure $ Left $ "Status code from " <> url <> " is not 200"
    Left e -> pure $ Left $ A.printError e <> ". Unable to fetch from " <> url

capitalize :: String -> String
capitalize s = case uncons s of
  Just o -> toString $ cons (toUpperSimple o.head) o.tail
  _ -> s

replaceAnd :: String -> String
replaceAnd = replaceAll (Pattern "&") (Replacement "and")

toFolderName :: String -> String
toFolderName = toKebabLowercase >>> replaceAnd

toKebabLowercase :: String -> String
toKebabLowercase = replaceAll (Pattern " ") (Replacement "-") >>> toLower
