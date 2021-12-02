module App.Component.Footer where

import App.Component.BackBtn (backBtn)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import Prelude
import React.Basic.DOM as R

mkFooter :: ComponentWithContext Unit
mkFooter = do
  mkComponentWithContext "Footer" \_ -> React.do
    pure $
      R.footer {
        className: "footer"
        , children: [backBtn {className: "footer__backBtn"}]
      }
