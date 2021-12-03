module Foreign.General where

import Prelude
import Effect (Effect)

-- TODO Effect Boolean?
foreign import isPreferColorSchemeDark :: Unit -> Boolean
foreign import goLastPage :: Unit -> Effect Unit
