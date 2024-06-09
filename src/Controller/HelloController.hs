{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Controller.HelloController where

import Servant

type HelloAPI = "hello" :> Get '[PlainText] String

helloServer :: Server HelloAPI
helloServer = return "Hello, Haskell!"
