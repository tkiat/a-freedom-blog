module App.Theme where

import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Foreign.General (isPreferColorSchemeDark)
import Prelude
import Web.HTML (window)
import Web.HTML.Window as Window
import Web.Storage.Storage as Storage

data Theme = Day | Dark

derive instance eqTheme :: Eq Theme

instance showTheme :: Show Theme where
  show Day = " Day "
  show Dark = "Night"

localStorageThemeField :: String
localStorageThemeField = "theme"

mkThemeInit :: Effect Theme
mkThemeInit = do
  localStorage <- Window.localStorage =<< window
  maybeLocal <- Storage.getItem localStorageThemeField localStorage
  let themePref = if isPreferColorSchemeDark unit then Dark else Day
  let local = fromMaybe (show themePref) maybeLocal
  pure $ fromMaybe Day (stringToTheme local)

storeTheme :: Theme -> Effect Unit
storeTheme x = do
  localStorage <- Window.localStorage =<< window
  Storage.setItem localStorageThemeField (show x) localStorage

stringToTheme :: String -> Maybe Theme
stringToTheme " Day " = Just Day
stringToTheme "Night" = Just Dark
stringToTheme _ = Nothing

toggleTheme :: Theme -> Theme
toggleTheme Dark = Day
toggleTheme Day = Dark
