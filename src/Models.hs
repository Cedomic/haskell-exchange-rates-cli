{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Models
    ( ExchangeRatesResponse(..)
    , Currency(..)
    )
where

import           Data.Aeson
import           Network.HTTP.Req
import           GHC.Generics
import           Data.Time

data Currency = EUR | USD | CAD | HKD | ISK | PHP | DKK | HUF | CZK | GBP | RON | SEK| IDR | INR | BRL | RUB | HRK | JPY | THB | CHF | MYR | BGN | TRY | CNY | NOK | NZD | ZAR | MXN | SGD | AUD | ILS | KRW | PLN deriving (Show, Read, Enum, Generic, Eq)
instance ToJSON Currency
instance FromJSON Currency

data ExchangeRatesResponse = ExchangeRatesResponse {
                   rates :: Object -- Data.HashMap.Strict.HashMap Currency Integer -- Object
                   ,  base :: Currency
                   , date :: Day
                   } deriving (Generic, Show)
instance ToJSON ExchangeRatesResponse
instance FromJSON ExchangeRatesResponse


