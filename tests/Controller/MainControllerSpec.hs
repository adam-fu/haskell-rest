{-# LANGUAGE OverloadedStrings, TypeFamilies, DataKinds #-}

module Controller.MainControllerSpec where

import Test.Hspec
import Control.Monad.IO.Class
import Servant
import Network.HTTP.Client       hiding (Proxy)
import Servant.Server
import Servant.Client
import Controller.MainController (RootAPI, rootServer)
import Network.Wai.Handler.Warp as Warp
import Client (testClient, withUserApp)

spec :: Spec
spec = do
  describe "rootServer" $ do
    around withUserApp $ do
      it "responds with 'You're at the main page!'" $ \port -> do
        Right (mainAPI, clientEnv) <- testClient (Proxy :: Proxy RootAPI) port
        result <- runClientM mainAPI clientEnv
        result `shouldBe` pure "You're at the main page!"
