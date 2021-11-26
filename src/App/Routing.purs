module App.Routing where

import App.Config (maybeUrlPrefixSite)
import Control.Monad.Reader (ReaderT(..))
import Data.Foldable as Foldable
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Partial.Unsafe as Partial.Unsafe
import Prelude
import React.Basic (JSX, ReactContext)
import React.Basic.Hooks as React
import React.Basic.Hooks (Hook, UseContext)
import Routing.Match as Match
import Routing.PushState as PushState

data AppRoute
  = About
  | ArticleTable String String
  | Article String String String

type ComponentWithContext props = ReaderT RouterContext Effect (props -> JSX)

type RouterContext = ReactContext (Maybe RouterContextValue)

type RouterContextValue = {
  route :: Maybe AppRoute
, nav :: PushState.PushStateInterface
}

appRoute :: Match.Match (Maybe AppRoute)
appRoute =
  Foldable.oneOf [
    Just <$> defaultRoute
  , Just <$> aboutRoute
  , Just <$> articleRoute
  , pure Nothing
  ]
  where
    defaultRoute = matchPrefix *> pure About <* Match.end
    aboutRoute = matchPrefix *> Match.lit "about" *> pure About <* Match.end
    articleRoute = matchPrefix *> Match.lit "article" *>
      Foldable.oneOf [
        Article <$> Match.str <*> Match.str <*> Match.str
      , ArticleTable <$> Match.str <*> Match.str
      ]
      <* Match.end
    matchPrefix = case maybeUrlPrefixSite of
      Just x -> Match.root *> Match.lit x
      Nothing -> Match.root

mkComponentWithContext ::
  forall props hooks.
  String ->
  (props -> React.Render Unit hooks JSX) -> ComponentWithContext props
mkComponentWithContext name render = ReaderT \_ -> React.component name render

useRouterContext ::
  RouterContext ->
  Hook (UseContext (Maybe RouterContextValue)) RouterContextValue
useRouterContext rc = React.do
  c <- React.useContext rc
  case c of
    Nothing -> Partial.Unsafe.unsafeCrashWith
      "useContext can only be used in a descendant of the corresponding \
      \context provider component"
    Just x -> pure x
