{-# LANGUAGE DeriveGeneric #-}

module Models
    ( ExchangeRatesResponse(..)
    , Currency(..)
    )
where

import           Data.Aeson
import           Network.HTTP.Req
import           GHC.Generics

data ExchangeRatesResponse = ExchangeRatesResponse { base :: Int
                   , bar :: Int} deriving (Generic, Show)
instance ToJSON ExchangeRatesResponse where
    toEncoding = genericToEncoding defaultOptions


data Currency = EUR | USD | CAD | HKD | ISK | PHP | DKK | HUF | CZK | GBP | RON | SEK| IDR | INR | BRL | RUB | HRK | JPY | THB | CHF | MYR | BGN | TRY | CNY | NOK | NZD | ZAR | MXN | SGD | AUD | ILS | KRW | PLN deriving (Show, Read, Enum)



