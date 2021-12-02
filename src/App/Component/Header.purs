module App.Component.Header where

import App.Component.Link (mkLink)
import App.Config (urlPrefixSite)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import App.Theme (Theme(..), storeTheme, toggleTheme)
import Effect (Effect)
import Prelude
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue)
import React.Basic.Events (handler)

type Props = {theme :: Theme, setTheme :: Theme -> Effect Unit}
mkHeader :: ComponentWithContext Props
mkHeader = do
  link <- mkLink
  mkComponentWithContext "Header" \{theme, setTheme} -> React.do
    pure $
      R.header {
        className: "header"
      , children: [
          R.div {
            className: "header__title"
          , children: [R.text "A Freedom Blog"]
          }
        , R.button {
            id: "theme-button"
          , className: "header__theme-button" <>
              if theme == Dark then " header__theme-button--dark" else ""
          , children: [R.text $ show $ toggleTheme theme]
          , onClick: handler targetValue $ (\_ ->
              let newTheme = toggleTheme theme
              in (setTheme newTheme) *> (storeTheme newTheme)
            )
          }
        ]
      }
