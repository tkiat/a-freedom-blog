module App.Component.Article where

import Affjax.ResponseFormat as ResponseFormat
import App.Article (ArticleSlug, Category, Subcategory)
import App.Config (urlPrefixPost)
import App.Component.Footer (mkFooter)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import App.Utils (asyncFetch, toFolderName)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String.Common (joinWith)
import Effect.Timer as Timer
import Foreign.Marked (toMarkdown)
import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks as React
import Web.Event.EventTarget (addEventListener, eventListener, removeEventListener)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.Window (scrollY, sessionStorage, toEventTarget)
import Web.Storage.Storage as Storage

--       maybePos <- Storage.getItem field sessionStorage
--       let posStr = fromMaybe "0" maybePos
--       let maybePosInt = fromString posStr
--       let posInt = fromMaybe 0 maybePosInt
--       Window.scroll 0 posInt w

type Props = {
  articleSlug :: ArticleSlug,
  category :: Category,
  subcategory :: Subcategory
}
mkArticle :: ComponentWithContext Props
mkArticle = do
  footer <- mkFooter
  mkComponentWithContext "Article"
    \{articleSlug: a, category: c, subcategory: s} -> React.do
    let field = s <> " - " <> a
    let url = joinWith "/"
          [urlPrefixPost, toFolderName c, toFolderName s, a <> ".md"]
    res <- asyncFetch ResponseFormat.string url
    React.useEffectOnce do
      w <- window
      ss <- sessionStorage =<< window

      let timeoutMs = 500
      e <- eventListener $ \_ -> do
        id <- Timer.setTimeout timeoutMs do
          yPos <- scrollY =<< window
          Storage.setItem field (show $ yPos) ss
        pure $ Timer.clearTimeout id

      addEventListener (EventType "scroll") e false (toEventTarget w)
      pure $ removeEventListener (EventType "scroll") e false (toEventTarget w)

    case res of
      Nothing -> pure $ R.text "Loading..."
      Just (Left e) -> pure $ R.text e
      Just (Right r) -> do
        -- TODO dangerous: use mutationobserver instead
        let content = toMarkdown field r
        pure $ R.div {
          className: "article"
        , children: [
            R.div {
              className: "article__content"
            , dangerouslySetInnerHTML: {__html: content}
            }
          , footer unit
          ]
        }
