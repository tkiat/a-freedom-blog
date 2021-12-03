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
import Foreign.Marked (toMarkdown)
import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks as React
import Web.Event.EventTarget (addEventListener, eventListener, removeEventListener)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.Window (scrollY, sessionStorage, toEventTarget)
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
--       Window.scroll 0 posInt w

      e <- eventListener $ \_ -> do
        sessionStorage <- sessionStorage =<< window
        yPos <- scrollY =<< window
        Storage.setItem field (show $ yPos) sessionStorage

      d <- eventListener $ \_ -> do
        sessionStorage <- sessionStorage =<< window
        Storage.setItem field "0" sessionStorage

      addEventListener (EventType "beforeunload") e false (toEventTarget w)
      addEventListener (EventType "popstate") d true (toEventTarget w)

      pure $ do
        removeEventListener (EventType "beforeunload") e false (toEventTarget w)
        removeEventListener (EventType "popstate") d true (toEventTarget w)

    case res of
      Nothing -> pure $ R.text "Loading..."
      Just (Left e) -> pure $ R.text e
      Just (Right r) -> do
        -- TODO dangerous: use mutationobserver instead
        -- https://stackoverflow.com/questions/44550462/reactjs-callback-for-dangerouslysetinnerhtml-complete
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
