{-# LANGUAGE OverloadedStrings, TypeFamilies, DataKinds #-}

module Controller.HelloControllerSpec where

import Test.Hspec
import Control.Monad.IO.Class
import Servant
import Network.HTTP.Client       hiding (Proxy)
import Servant.Server
import Servant.Client
import Controller.HelloController (HelloAPI, helloServer)
import Network.Wai.Handler.Warp as Warp
import Server (app)
import Client (testClient, withUserApp)


spec :: Spec
spec = do
  describe "rootServer" $ do
    around withUserApp $ do
      it "responds with 'Hello, Haskell!'"  $ \port -> do
        Right (mainAPI, clientEnv) <- testClient (Proxy :: Proxy HelloAPI) port
        result <- runClientM mainAPI clientEnv
        result `shouldBe` pure "Hello, Haskell!"
