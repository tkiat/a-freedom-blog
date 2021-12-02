module App.Component.BlogStructure where

import App.Article (CategoryObj)
import App.Component.Link (mkLink)
import App.Config (urlPrefixSite)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import Prelude
import React.Basic (fragment)
import React.Basic.DOM as R

type Props = {metadata :: Array CategoryObj}
mkBlogStructure :: ComponentWithContext Props
mkBlogStructure = do
  link <- mkLink
  mkComponentWithContext "BlogStructure" \{metadata} ->
    pure $
      R.nav {
        className: "blog-structure"
      , children: flip map metadata (\co ->
          fragment [
            link {
              className: "category-menu__link"
            , to: urlPrefixSite <> "/article/" <> co.category <> "/all"
            , children: [R.text co.category]
            },
            R.ul {
              className: "TODO"
            , children: flip map co.children (\so ->
                R.li {
                  className: "TODO"
                , children: [
                    link {
                      className: "category-menu__link"
                    , to: urlPrefixSite <> "/article/" <> so.subcategory
                          <> "/all"
                    , children: [R.text so.subcategory]
                    }
                  ]
                }
              )
            }
          ]
        )
      }
