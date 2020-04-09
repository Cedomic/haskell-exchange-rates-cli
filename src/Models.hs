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
import           Data.Text
import           Data.Scientific
import           Data.Hashable
import           Data.Time

data Currency = EUR | USD | CAD | HKD | ISK | PHP | DKK | HUF | CZK | GBP | RON | SEK| IDR | INR | BRL | RUB | HRK | JPY | THB | CHF | MYR | BGN | TRY | CNY | NOK | NZD | ZAR | MXN | SGD | AUD | ILS | KRW | PLN deriving (Show, Read, Enum, Generic, Eq)
instance ToJSON Currency
instance FromJSON Currency

newtype Rates = Rates (Currency, Scientific) deriving (Generic, Show)
instance ToJSON Rates
instance FromJSON Rates

data ExchangeRatesResponse = ExchangeRatesResponse {
                   rates :: Object -- HashMap Currency Scientific -- Object
                   ,  base :: Currency
                   , date :: Day
                   } deriving (Generic, Show)
instance ToJSON ExchangeRatesResponse
instance FromJSON ExchangeRatesResponse


