module App.Component.App where

import Affjax.ResponseFormat as ResponseFormat
import App.Component.About (about)
import App.Component.Article (mkArticle)
import App.Component.ArticleTable (mkArticleTable)
import App.Component.BlogStructure (mkBlogStructure)
import App.Component.Header (mkHeader)
import App.Article (CategoryObj)
import App.Config (urlPrefixPost)
import App.Routing (ComponentWithContext, AppRoute(..), mkComponentWithContext, useRouterContext)
import App.Theme (Theme(..))
import App.Utils (asyncFetch)
import Control.Monad.Reader (ask)
import Data.Argonaut.Decode (decodeJson)
import Data.Either (Either(..))
import Data.Foldable (find)
import Data.Maybe (Maybe(..), isJust)
import Prelude
import React.Basic (fragment)
import React.Basic.DOM as R
import React.Basic.Hooks as Hooks
import React.Basic.Hooks ((/\))

type Props = {themeInit :: Theme}
mkApp :: ComponentWithContext Props
mkApp = do
  ctx <- ask
  article <- mkArticle
  articleTable <- mkArticleTable
  blogStructure <- mkBlogStructure
  header <- mkHeader
  mkComponentWithContext "App" \{themeInit} -> Hooks.do
    {route} <- useRouterContext ctx
    theme /\ setTheme <- Hooks.useState' themeInit
    res <- asyncFetch ResponseFormat.json (urlPrefixPost <> "/metadata.json")
    case res of
      Nothing -> pure $ R.text "Loading..."
      Just (Left e) -> pure $ R.text e
      Just (Right j) -> case decodeJson j of
        Left _ -> pure $ R.text "Cannot decode article metadatas"
        Right (metadata :: Array CategoryObj) -> do
          let categories = map (\a -> a.category) metadata
          let categoryCur = case route of
                Just (ArticleTable p1 _) -> p1
                Just (Article p1 _ _) -> p1
                _ -> ""
          pure $ R.div {
            className: "app__inner" <>
              if theme == Dark then " app__inner--dark" else ""
          , children: [
              header {theme, setTheme}
            , case route of
                Just About -> 
                  R.div {
                    className: "app__main"
                  , children: [blogStructure {metadata}, about]
                  }
                Just (ArticleTable p1 p2) ->
                  case find (\x -> x.category == p1) metadata of
                  Just c -> do
                    if p2 == "all" ||
                       isJust(find (\x -> x.subcategory == p2) c.children)
                      then R.div {
                        className: "app__main"
                      , children: [
                          blogStructure {metadata}
                        , articleTable {categoryObj: c, subcategory: p2}
                        ]
                      }
                      else R.text $ "No subcategory '" <> p2 <> "'. Check URL."
                  _ -> R.text $ "No category '" <> p1 <> "'. Check URL."
                Just (Article p1 p2 p3) ->
                  article {category: p1, subcategory: p2, articleSlug: p3}
                Nothing -> R.h1_ [R.text "Not found"]
            ]
          }
