module App.Config (
  maybeUrlPrefixSite
, urlPrefixPost
, urlPrefixSite
) where

import Data.Maybe (Maybe(..))
import Prelude

-- an extra URL prefix e.g. for GitHub pages like Just "a-freedom-blog"
maybeUrlPrefixSite :: Maybe String
maybeUrlPrefixSite = Nothing

serveLocalPost :: Boolean
serveLocalPost = false

urlPrefixPost :: String
urlPrefixPost =
  if serveLocalPost
    then "../../my-writings-public/blog"
    else "https://raw.githubusercontent.com/tkiat/my-writings-public/main/blog"

urlPrefixSite :: String
urlPrefixSite = case maybeUrlPrefixSite of
  Just x -> "/" <> x
  Nothing -> ""
