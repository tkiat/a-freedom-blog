module App.Component.BackBtn where

import Foreign.General (goLastPage)
import Prelude
import React.Basic.DOM as R
import React.Basic.DOM.Events (preventDefault)
import React.Basic.Events (handler)
import React.Basic.Hooks as React

type Props = {className :: String}
backBtn :: Props -> React.JSX
backBtn = \{className} ->
  R.a {
    href: "#"
  , className
  , children: [R.text "Back"]
  , onClick: handler preventDefault $ \_ -> goLastPage unit
  }
