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
    then "/post"
    else "https://raw.githubusercontent.com/tkiat/assets-public/main/post"

urlPrefixSite :: String
urlPrefixSite = case maybeUrlPrefixSite of
  Just x -> "/" <> x
  Nothing -> ""
