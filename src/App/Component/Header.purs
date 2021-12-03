module App.Component.Header where

import App.Component.BackBtn (backBtn)
import App.Component.Link (mkLink)
import App.Config (urlPrefixSite)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import App.Theme (Theme(..), storeTheme, toggleTheme)
import Effect (Effect)
import Effect.Console (log)
import Prelude
import React.Basic.DOM as R
import React.Basic.DOM.Events (targetValue)
import React.Basic.Events (handler)
import Web.HTML (window)
import Web.HTML.Window as Window

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
        , backBtn {
            className: "header__backBtn" <>
              if hideBackBtn then " header__backBtn--hidden" else ""
          }
        , R.button {
            className: "header__theme-button" <>
              if theme == Dark then " header__theme-button--dark" else ""
          , id: "theme-button"
          , children: [R.text $ show $ toggleTheme theme]
          , onClick: handler targetValue $ \_ -> do
              window >>= Window.scroll 0 500
              yPos <- Window.scrollY =<< window
              log $ show $ yPos

--           , onClick: handler targetValue $ \_ ->
--               let newTheme = toggleTheme theme
--               in (setTheme newTheme) *> (storeTheme newTheme)
          }
        ]
      }
