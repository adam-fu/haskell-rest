{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Controller.MainController where

import Servant

type RootAPI = Get '[PlainText] String

rootServer :: Server RootAPI
rootServer = return "You're at the main page!"
