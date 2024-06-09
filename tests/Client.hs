module Client where

import Control.Monad.IO.Class
import Servant
import Network.HTTP.Client       hiding (Proxy)
import Servant.Server
import Servant.Client
import Server (API)
import Controller.HelloController (HelloAPI, helloServer)
import Network.Wai.Handler.Warp as Warp
import Server (app)

testClient :: HasClient ClientM api => Proxy api -> Int
           -> IO (Either ClientError (Client ClientM api, ClientEnv))
testClient proxy port = do
  baseUrl <- parseBaseUrl "http://localhost/"
  manager <- newManager defaultManagerSettings
  let tClient = client proxy

  let clientEnv = mkClientEnv manager (baseUrl { baseUrlPort = port })
  return (Right (tClient, clientEnv))
  -- runClient (tClient) (clientEnv port)

withUserApp :: (Warp.Port -> IO ()) -> IO ()
withUserApp action =
  -- testWithApplication makes sure the action is executed after the server has
  -- started and is being properly shutdown.
  Warp.testWithApplication (pure app) action
