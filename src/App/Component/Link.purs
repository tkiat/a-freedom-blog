module App.Component.Link where

import App.Routing (ComponentWithContext, mkComponentWithContext, useRouterContext)
import Control.Monad.Reader as Reader
import Foreign as Foreign
import Prelude
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Events as React.DOM.Events
import React.Basic.Events as React.Events
import React.Basic.Hooks as React

type Props = {children :: Array JSX, className :: String, to :: String}
mkLink :: ComponentWithContext Props
mkLink = do
  ctx <- Reader.ask
  mkComponentWithContext "Link" \{children, className, to} -> React.do
    {nav} <- useRouterContext ctx
    pure $
      R.a {
        href: to
      , className: className
      , onClick:
          React.Events.handler React.DOM.Events.preventDefault
            \_ -> nav.pushState (Foreign.unsafeToForeign unit) to
      , children
      }
