module App.Component.RouterProvider where

import App.Routing (AppRoute(..), ComponentWithContext, appRoute, mkComponentWithContext)
import Control.Monad.Reader (ask)
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import Prelude
import React.Basic (JSX)
import React.Basic as React.Basic
import React.Basic.Hooks as React
import React.Basic.Hooks ((/\))
import Routing.PushState as PushState

mkRouterProvider :: ComponentWithContext (Array JSX)
mkRouterProvider = do
  c <- ask
  nav <- liftEffect PushState.makeInterface
  mkComponentWithContext "Router" \children -> React.do
    let routerProvider = React.Basic.provider c
    route /\ setRoute <- React.useState' (Just About)
    React.useEffectOnce do
      nav # PushState.matches appRoute \_ newRoute -> setRoute newRoute
    pure (routerProvider (Just {nav, route}) children)
