module App.Config where

import Data.Maybe (Maybe(..))
import Prelude

-- an extra URL prefix e.g. for GitHub pages like
-- https://www.tkiat.github.io/a-freedom-blog
maybeUrlPrefixSite :: Maybe String
maybeUrlPrefixSite = Nothing

serveLocalPost :: Boolean
serveLocalPost = false

urlMetadata :: String
urlMetadata = urlPrefixPost <> "/metadata.json"

urlPrefixPost :: String
urlPrefixPost =
  if serveLocalPost
    then "/blog"
    else "https://raw.githubusercontent.com/tkiat/my-writings-public/main/blog"

urlPrefixSite :: String
urlPrefixSite = case maybeUrlPrefixSite of
  Just x -> "/" <> x
  Nothing -> ""
