module Foreign.General where

import Prelude
import Effect (Effect)

foreign import isPreferColorSchemeDark :: Unit -> Boolean
foreign import goLastPage :: Unit -> Effect Unit
