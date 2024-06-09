{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Server where

import Network.Wai.Handler.Warp (run)
import Servant
import Controller.HelloController (HelloAPI, helloServer)
import Controller.MainController (RootAPI, rootServer)

type API = "hello" :> Get '[PlainText] String
        :<|> Get '[PlainText] String

server :: Server API
server = helloServer :<|> rootServer

api :: Proxy API
api = Proxy

app :: Application
app = serve api server

runServer :: IO ()
runServer = run 8080 app
