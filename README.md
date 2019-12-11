# Account and money exchange mini-system

As the name says, this system provides a set of features which allow the user to create and do simple operations involving their accounts and money exchanges.

## Running

To start the system in interactive mode, run the following command in the terminal.

```
iex -S mix 

```

## Accounts

An account is a elixir struct which contains the necessary information to perform financial operations. Each account is composed by the following fields:

* Owner: The name of the account’s owner 
* Currency: The code of the account currency. The code is given by ISO 4217. This version supports the currencies: “BRL”, “JOD”, “CNY” and “JPY”.
* Decimals: The number of decimals after comma in the account currency. This number is also given by ISO 4217.
* Integer balance: The integer part of the account balance.
* Fractionary balance: The decimal part of the account balance.

Aiming to simplify the account creation process, the system provides a factory to create these 4 types of accounts. The user can create accounts running the following commands in the interactive terminal:

```elixir
iex> joao = AccountFactory.factory("BRL", "Joao")
%AccountBRL{
  currency: "BRL",
  decimals: 2,
  fractionary_balance: 0,
  integer_balance: 0,
  owner: "Joao"
}
iex> uzumaki = AccountFactory.factory("JPY", "Uzumaki")
%AccountJPY{
  currency: "JPY",
  decimals: 0,
  fractionary_balance: 0,
  integer_balance: 0,
  owner: "Uzumaki"
}

```
The default values for Integer and Fractional balance are 0. Decimals will be defined by the selected currency.


**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `stone_challenge` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stone_challenge, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/stone_challenge](https://hexdocs.pm/stone_challenge).

