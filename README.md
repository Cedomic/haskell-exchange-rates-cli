# haskell-exchange-rates-cli

Simple CLI tool to fetch exchange rates written in Haskell

## Usage

Prerequisities:

`Haskell + Stack on your machine`


    git clone https://github.com/Cedomic/haskell-exchange-rates-cli.git
    
    cd haskell-exchange-rates-cli

    stack build

    stack run

The tool doesn't do much at the moment. You can enter a currency (e.g. EUR or USD) and get the exchange rates from `api.exchangeratesapi.io`.

Possible currencies:

    data Currency = EUR | USD | CAD | HKD | ISK | PHP | DKK | HUF | CZK | GBP | RON | SEK| IDR | INR | BRL | RUB | HRK | JPY | THB | CHF | MYR | BGN | TRY | CNY | NOK | NZD | ZAR | MXN | SGD | AUD | ILS | KRW | PLN deriving (Show, Read, Enum, Generic, Eq)

