module Main where

import App.Component.App (mkApp)
import App.Component.RouterProvider (mkRouterProvider)
import App.Theme (mkThemeInit)
import Control.Monad.Reader as Reader
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception as Exception
import Prelude
import React.Basic.DOM (render)
import React.Basic.Hooks as React
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window as Window

-- TODO shift title and theme to 70% whenopen article

main :: Effect Unit
main = do
  themeInit <- mkThemeInit

  doc <- Window.document =<< window
  getElementById "app" (toNonElementParentNode doc) >>= case _ of
    Nothing -> Exception.throw "element with id 'app' not found"
    Just a -> do
      ctx <- React.createContext Nothing
      routerProvider <- Reader.runReaderT mkRouterProvider ctx
      app <- Reader.runReaderT mkApp ctx
      render (routerProvider [app {themeInit}]) a
