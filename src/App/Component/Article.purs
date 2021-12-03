module App.Component.Article where

import Affjax.ResponseFormat as ResponseFormat
import App.Article (ArticleSlug, Category, Subcategory)
import App.Config (urlPrefixPost)
import App.Component.Footer (mkFooter)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import App.Utils (asyncFetch, toFolderName)
import Data.Either (Either(..))
import Data.Int (fromString)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String.Common (joinWith)
import Effect.Console (log)
import Foreign.Marked (toMarkdown)
import Foreign.General (getYPos, scrollTo)
import Prelude
import React.Basic.DOM as R
import React.Basic.Events (handler)
import React.Basic.Hooks as React
import Web.Event.EventTarget (EventListener(..), addEventListener, eventListener, removeEventListener)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.Event.BeforeUnloadEvent.EventTypes (beforeunload)
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
    let url = joinWith "/"
          [urlPrefixPost, toFolderName c, toFolderName s, a <> ".md"]
    res <- asyncFetch ResponseFormat.string url
    React.useEffectOnce do
      sessionStorage <- Window.sessionStorage =<< window

      let field = s <> a
      maybePos <- Storage.getItem field sessionStorage
      let posStr = fromMaybe "0" maybePos
      let maybePosInt = fromString posStr
      let posInt = fromMaybe 0 maybePosInt
      window >>= Window.scroll 0 500
      e <- eventListener $ \_ -> do
        yPos <- Window.scrollY =<< window
        log $ show yPos
        log "beforeunload"
      w <- window
      addEventListener (EventType "beforeunload") e false (Window.toEventTarget w)
      pure $ do
        log "removeEventListener"
        removeEventListener (EventType "beforeunload") e false (Window.toEventTarget w)
--         log "g"
--       (EventListener false)
--       scrollTo posInt
--       window >>= Window.scrollBy 0 500
--       \_ -> do
--         yPos <- Window.scrollY =<< window
--         log $ show $ yPos
--       pure $ do
--         yPos <- getYPos unit
--         yPos' <- Window.scrollY =<< window
--         log $ "noob " <> show yPos'
--         Storage.setItem field (show $ getYPos unit) sessionStorage
    case res of
      Nothing -> pure $ R.text "Loading..."
      Just (Left e) -> pure $ R.text e
      Just (Right r) -> pure $
        R.div {
          className: "article"
        , children: [
            R.div {
              className: "article__content"
            , dangerouslySetInnerHTML: {__html: toMarkdown r}
            }
          , footer unit
          ]
        }
