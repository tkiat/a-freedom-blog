module App.Component.Article where

import Affjax.ResponseFormat as ResponseFormat
import App.Article (ArticleSlug, Category, Subcategory)
import App.Config (urlPrefixPost)
import App.Component.Footer (mkFooter)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import App.Utils (asyncFetch, toFolderName)
import Data.Either (Either(..))
import Data.Int (fromString, toNumber)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String.Common (joinWith)
import Data.Time.Duration (Milliseconds(..))
import Effect.Aff (delay, launchAff_)
import Effect.Console (log)
import Foreign.Marked (toMarkdown)
import Foreign.General (getYPos, scrollTo)
import Prelude
import React.Basic.DOM as R
import React.Basic.Events (handler)
import React.Basic.Hooks as React
import Web.DOM.MutationObserver (mutationObserver)
import Web.Event.EventTarget (EventListener(..), addEventListener, eventListener, removeEventListener)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.Window as Window
import Web.Storage.Storage as Storage

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
    let field = s <> a
    let url = joinWith "/"
          [urlPrefixPost, toFolderName c, toFolderName s, a <> ".md"]
    res <- asyncFetch ResponseFormat.string url
    React.useEffectOnce do
      w <- window
--       maybePos <- Storage.getItem field sessionStorage
--       let posStr = fromMaybe "0" maybePos
--       let maybePosInt = fromString posStr
--       let posInt = fromMaybe 0 maybePosInt
-- 
--       Window.scroll 0 posInt w

      e <- eventListener $ \_ -> do
        sessionStorage <- Window.sessionStorage =<< window
        yPos <- Window.scrollY =<< window
        Storage.setItem field (show $ yPos) sessionStorage

      d <- eventListener $ \_ -> do
        sessionStorage <- Window.sessionStorage =<< window
        Storage.setItem field "0" sessionStorage

      addEventListener (EventType "beforeunload") e false (Window.toEventTarget w)
      addEventListener (EventType "popstate") d true (Window.toEventTarget w)

      pure $ do
        removeEventListener (EventType "beforeunload") e false (Window.toEventTarget w)
        removeEventListener (EventType "popstate") d true (Window.toEventTarget w)

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
