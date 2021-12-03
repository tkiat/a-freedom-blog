module Foreign.General where

import Prelude
import Effect (Effect)

-- TODO Effect Boolean?
foreign import isPreferColorSchemeDark :: Unit -> Boolean
foreign import getYPos :: Unit -> Int
foreign import goLastPage :: Unit -> Effect Unit
foreign import scrollTo :: Int -> Effect Unit
