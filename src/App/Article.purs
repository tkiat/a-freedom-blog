module App.Article where

import Data.Array (concat)
import Data.Foldable (find)
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Prelude
import Prim.Row (class Lacks)
import Record as Record

type Category = String
type Subcategory = String

type ArticleDate = String
type ArticleSlug = String
type ArticleTitle = String

type ArticleFields = (
  date :: ArticleDate,
  slug :: ArticleSlug,
  title :: ArticleTitle
)
type ArticleObj = Record ArticleFields
type ArticleObjWithSubcategory = {subcategory :: Subcategory | ArticleFields}

type SubcategoryObj = {
  subcategory :: Subcategory,
  children :: Array ArticleObj
}
type CategoryObj = {
  category :: Category,
  children :: Array SubcategoryObj
}

getUnsortedArticleObjs ::
  CategoryObj -> Subcategory -> Array ArticleObjWithSubcategory
getUnsortedArticleObjs co s = case s of
  "all" -> concat $ map
    (\x -> map (insertSubcategoryField x.subcategory) x.children)
    co.children
  _ -> case find (\x -> x.subcategory == s) co.children of
    Just x -> map (insertSubcategoryField s) x.children
    Nothing -> []

insertSubcategoryField ::
  forall r. Lacks "subcategory" r =>
  Subcategory -> {| r} -> {subcategory :: Subcategory | r}
insertSubcategoryField = Record.insert (SProxy :: _ "subcategory")
