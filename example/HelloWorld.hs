module HelloWorld where

import Data.Text (Text)
import Web.Hyperbole


main :: IO ()
main = do
  run 3000 $ do
    liveApp (basicDocument "Example") (runPage messagePage')


data Message = Message
  deriving (Show, Read, ViewId)


data MessageAction = SetMessage Text
  deriving (Show, Read, ViewAction)


instance HyperView Message where
  type Action Message = MessageAction
instance Handle Message es where
  handle (SetMessage m) = do
    -- side effects
    pure $ messageView' m


messageView' :: Text -> View Message ()
messageView' m = do
  el bold "Message"
  el_ (text m)
  button (SetMessage "Goodbye World") id "Change Message"


messagePage' :: (Hyperbole :> es) => Page es '[Message]
messagePage' = do
  pure $ do
    el bold "Message Page"
    hyper Message $ messageView' "Hello World"
