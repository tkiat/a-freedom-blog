module App.Component.SubcategoryMenu where

import App.Article (CategoryObj, Subcategory)
import App.Component.Link (mkLink)
import App.Config (urlPrefixSite)
import App.Routing (ComponentWithContext, mkComponentWithContext)
import Prelude
import React.Basic.DOM as R

type Props = {categoryObj :: CategoryObj, subcategory :: Subcategory}
mkSubcategoryMenu :: ComponentWithContext Props
mkSubcategoryMenu = do
  link <- mkLink
  mkComponentWithContext "SubcategoryMenu"
    \{categoryObj: co, subcategory: s} -> React.do
    let subcategories = map (\x -> x.subcategory) co.children
    pure $
      R.nav {
        className: "subcategory-menu"
      , children: [
          R.ul {
            className: "subcategory-menu__list"
          , children: flip map subcategories (\x ->
              R.li {
                className: "subcategory-menu__item" <>
                  if x == s then " subcategory-menu__item--selected" else ""
              , children: [
                  link {
                    className: "subcategory-menu__link"
                  , to: urlPrefixSite <> "/article/" <> co.category <> "/" <> x
                  , children: [R.text x]
                  }
                ]
              }
            )
          }
        ]
      }
