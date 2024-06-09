{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Server
import Controller.HelloController (HelloAPI, helloServer)
import Controller.MainController (RootAPI, rootServer)


main :: IO ()
main = do
  Server.runServer
