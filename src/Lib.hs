{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( execReq
    )
where

import           Control.Monad.IO.Class
import           Data.Aeson
import           Network.HTTP.Req
import           Models



execReq :: IO ()
execReq = do
    putStrLn "Enter a base currency pair (e.g. EUR or USD)"
    baseCurrency          <- getLine
    responseExchangeRates <- exchangeRates baseCurrency
    liftIO $ print (responseBody responseExchangeRates :: Value)

exchangeRates :: (MonadIO m, FromJSON a) => String -> m (JsonResponse a)
exchangeRates baseCurrency = runReq defaultHttpConfig $ req
    GET
    (https "api.exchangeratesapi.io" /: "latest")
    NoReqBody
    jsonResponse
    ("base" =: (baseCurrency :: String))





