{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( execReq
    )
where

import           Control.Monad.IO.Class
import           Data.Aeson
import           Utils                          ( uppercase
                                                , removeSlash
                                                , removeNumber
                                                , objectToTupleList
                                                )
import           Network.HTTP.Req
import           Models



execReq :: IO ()
execReq = do
    putStrLn "\nEnter a base currency pair (e.g. EUR or USD):"
    baseCurrency          <- getLine
    responseExchangeRates <- exchangeRates $ uppercase baseCurrency
    liftIO $ putStr
        (getResponseString
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


getResponseString :: ExchangeRatesResponse -> String
getResponseString r =
    "The exchange rates for the currency "
        ++ show (base r)
        ++ " on the "
        ++ show (date r)
        ++ " is:"
        ++ "\n\n"
        ++ getExchangeRatesString (rates r)

getExchangeRatesString :: Object -> String
getExchangeRatesString r = unlines
    ( map
            (\(currency, exchangeRate) ->
                "  - "
                    ++ removeSlash currency
                    ++ " = "
                    ++ removeNumber exchangeRate
            )
    $ objectToTupleList r
    )









