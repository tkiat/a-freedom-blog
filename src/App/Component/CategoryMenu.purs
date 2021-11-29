module App.Component.CategoryMenu where

import App.Article (Category)
import App.Component.Link (mkLink)
import App.Config (urlPrefixSite)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import Prelude
import React.Basic.DOM as R

type Props = {categories :: Array Category, cur :: Category}
mkCategoryMenu :: ComponentWithContext Props
mkCategoryMenu = do
  link <- mkLink
  mkComponentWithContext "CategoryMenu" \p ->
    pure $
      R.nav {
        className: "category-menu"
      , children: [
          R.ul {
            className: "category-menu__list"
          , children: flip map p.categories (\x ->
              R.li {
                className: "category-menu__item" <>
                  if x == p.cur
                    then " category-menu__item--selected"
                    else ""
              , children: [
                  link {
                    className: "category-menu__link"
                  , to: urlPrefixSite <> "/article/" <> x <> "/all"
                  , children: [R.text x]
                  }
                ]
              }
            )
          }
        ]
      }
