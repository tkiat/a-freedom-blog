module App.Component.Footer where

import App.Routing (ComponentWithContext, mkComponentWithContext)
import Prelude
import React.Basic.DOM as R

mkFooter :: ComponentWithContext Unit
mkFooter = do
  mkComponentWithContext "Footer" \_ -> React.do
    pure $
      R.footer {
        className: "footer"
      , children: [
          R.a {
            href: "javascript:history.back()"
          , className: "footer__back"
          , children: [R.text "Back"]
          }
        ]
      }
