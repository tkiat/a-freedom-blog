module App.Component.Article where

import Affjax.ResponseFormat as ResponseFormat
import App.Article (ArticleSlug, Category, Subcategory)
import App.Config (urlPrefixPost)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import App.Utils (asyncFetch)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String.Common (joinWith)
import Foreign.Marked (toMarkdown)
import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks as React

type Props = {
  articleSlug :: ArticleSlug,
  category :: Category,
  subcategory :: Subcategory
}
mkArticle :: ComponentWithContext Props
mkArticle = do
  mkComponentWithContext "Article"
    \{articleSlug: as, category: c, subcategory: s} -> React.do
    let url = joinWith "/" [urlPrefixPost, c, s, as <> ".md"]
    res <- asyncFetch ResponseFormat.string url
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
          ]
        }
