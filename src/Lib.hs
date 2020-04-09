{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( execReq
    )
where

import           Control.Monad.IO.Class
import           Data.Aeson
import           Network.HTTP.Req
import           Models
import           Data.Text
import qualified Data.HashMap.Strict
import qualified Data.List
import qualified Data.Char                      ( toUpper )


execReq :: IO ()
execReq = do
    putStrLn "\nEnter a base currency pair (e.g. EUR or USD)"
    baseCurrency          <- getLine
    responseExchangeRates <- exchangeRates $ uppercase baseCurrency
    liftIO $ putStrLn
        (getExchangeRatesString
            (responseBody responseExchangeRates :: ExchangeRatesResponse)
        )
    execReq

exchangeRates :: (MonadIO m, FromJSON a) => String -> m (JsonResponse a)
exchangeRates baseCurrency = runReq defaultHttpConfig $ req
    GET
    (https "api.exchangeratesapi.io" /: "latest")
    NoReqBody
    jsonResponse
    ("base" =: (baseCurrency :: String))


getExchangeRatesString :: ExchangeRatesResponse -> String
getExchangeRatesString r =
    "The exchange rate for the currency "
        ++ show (base r)
        ++ " on the "
        ++ show (date r)
        ++ " is:"
        ++ show
               (Data.List.intercalate
                   "\n - "
                   (Prelude.map
                       (\(currency, exchangeRate) ->
                           removeSlash (show currency) ++ " = " ++ removeSlash
                               (show exchangeRate)
                       )
                       (Data.HashMap.Strict.toList $ rates r)
                   )
               )


uppercase = Prelude.map Data.Char.toUpper

removeSlash ('\"' : c : rest) = c : removeSlash rest
removeSlash (c        : rest) = c : removeSlash rest
removeSlash []                = []
