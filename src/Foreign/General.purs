module Foreign.General where

import Prelude
import Effect (Effect)

foreign import isPreferColorSchemeDark :: Unit -> Effect Boolean
foreign import goLastPage :: Unit -> Effect Unit
