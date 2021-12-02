module App.Component.BlogStructure where

import App.Article (CategoryObj)
import App.Component.Link (mkLink)
import App.Config (urlPrefixSite)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import Prelude
import React.Basic.DOM as R

type Props = {metadata :: Array CategoryObj, url :: {p1 :: String, p2 :: String}}
mkBlogStructure :: ComponentWithContext Props
mkBlogStructure = do
  link <- mkLink
  mkComponentWithContext "BlogStructure" \{metadata, url: {p1, p2}} ->
    pure $ R.div {
      className: "blog-structure"
    , children: [
        link {
          className: "blog-structure__link" <>
            if p1 == "about" && p2 == ""
              then " blog-structure__link--active" else ""
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
                      className: "blog-structure__link" <>
                        if p1 == co.category && p2 == "all"
                          then " blog-structure__link--active" else ""
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
                              className: "blog-structure__link" <>
                                if p1 == co.category && p2 == so.subcategory
                                  then " blog-structure__link--active" else ""
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
