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

type Props = {
  hideBackBtn :: Boolean,
  theme :: Theme,
  setTheme :: Theme -> Effect Unit
}
mkHeader :: ComponentWithContext Props
mkHeader = do
  link <- mkLink
  mkComponentWithContext "Header" \{hideBackBtn, theme, setTheme} -> React.do
    pure $
      R.header {
        className: "header"
      , children: [
          link {
            className: "header__title"
          , to: urlPrefixSite <> "/about"
          , children: [R.text "A Freedom Blog"]
          }
        , R.a {
            href: "javascript:history.back()"
          , className: "header__back" <>
              if hideBackBtn then " header__back--hidden" else ""
          , children: [R.text "Back"]
          }
        , R.button {
            className: "header__theme-button" <>
              if theme == Dark then " header__theme-button--dark" else ""
          , id: "theme-button"
          , children: [R.text $ show $ toggleTheme theme]
          , onClick: handler targetValue $ (\_ ->
              let newTheme = toggleTheme theme
              in (setTheme newTheme) *> (storeTheme newTheme)
            )
          }
        ]
      }
