module App.Component.BlogStructure where

import App.Article (CategoryObj)
import App.Component.Link (mkLink)
import App.Config (urlPrefixSite)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import Prelude
import React.Basic.DOM as R

type Props = {metadata :: Array CategoryObj}
mkBlogStructure :: ComponentWithContext Props
mkBlogStructure = do
  link <- mkLink
  mkComponentWithContext "BlogStructure" \{metadata} ->
    pure $ R.div {
      className: "blog-structure"
    , children: [
        link {
          className: "blog-structure__link blog-structure__link--header"
        , to: urlPrefixSite <> "/about"
        , children: [R.text "About"]
        },
        R.nav {
          className: "blog-structure__nav"
        , children: [
            R.ul {
              className: "blog-structure__list"
            , children: flip map metadata (\co ->
                R.li {
                  className: "blog-structure__list-item"
                , children: [
                    link {
                      className: "blog-structure__link"
                    , to: urlPrefixSite <> "/article/" <> co.category <> "/all"
                    , children: [R.text co.category]
                    },
                    R.ul {
                      className: "blog-structure__list"
                    , children: flip map co.children (\so ->
                        R.li {
                          className: "blog-structure__list-item"
                        , children: [
                            link {
                              className: "blog-structure__link"
                            , to: urlPrefixSite <> "/article/" <> co.category
                                <> "/" <> so.subcategory
                            , children: [R.text so.subcategory]
                            }
                          ]
                        }
                      )
                    }
                  ]
                }
              )
            }
          ]
        }
      ]
    }
