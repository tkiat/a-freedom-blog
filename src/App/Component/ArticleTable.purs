module App.Component.ArticleTable where

import App.Article (CategoryObj, Subcategory, getUnsortedArticleObjs)
import App.Component.Link (mkLink)
import App.Config (urlPrefixSite)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import Data.Array (reverse, sort)
import Prelude
import React.Basic.DOM as R

type Props = {categoryObj :: CategoryObj, subcategory :: Subcategory}
mkArticleTable :: ComponentWithContext Props
mkArticleTable = do
  link <- mkLink
  mkComponentWithContext "ArticleTable"
    \{categoryObj: co, subcategory: s} -> React.do
    let sortedArticles = (reverse <<< sort) $ getUnsortedArticleObjs co s
    pure $
      R.table {
        className: "article-table"
      , children: [
          R.thead_ [
            R.tr_ [
              R.th {
                className: "article-table__header-date"
              , children: [R.text "Date"]
              }
            , R.th {
                className: "article-table__header-title"
              , children: [R.text "Title"]
              }
            ]
          ]
        , R.tbody {
            children: flip map sortedArticles (\a ->
              R.tr {
                className: "article-table__body-row"
              , children: [
                  R.td {
                    className: "article-table__body-date"
                  , children: [R.text a.date]
                  }
                , R.td {
                    className: "article-table__body-title"
                  , children: [
                      link {
                        className: "article-table__body-link"
                      , to:
                          urlPrefixSite <> "/article/" <> co.category
                          <> "/" <> a.subcategory <> "/" <> a.slug
                      , children: [R.text a.title]
                      }
                    ]
                  }
                ]
              }
            )
          }
        ]
      }
