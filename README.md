# Account and money exchange mini-system

As the name says, this system provides a set of features which allow the user to create and do simple operations involving their accounts and money exchanges.

## Running

To start the system in interactive mode, run the following command in the terminal.

```
iex -S mix 

```

The system also has a simple suit of tests. The user can execute them running the following command in the terminal.

```
mix test


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

## Financial operations

The system provides the financial methods: Credit, Debit and Transference. 
To make a credit or debit operation, the user must give as arguments the target account, the integer and the fractional values of the credit / debit. The return of this method is the updated account struct. Usage examples are in following.

```elixir
iex> joao = Bank.credit_account(joao, 30, 20)
%AccountBRL{
  currency: "BRL",
  decimals: 2,
  fractionary_balance: 20,
  integer_balance: 30,
  owner: "Joao"
}
iex> joao = Bank.debit_account(joao, 10, 90)
%AccountBRL{
  currency: "BRL",
  decimals: 2,
  fractionary_balance: 30,
  integer_balance: 19,
  owner: "Joao"
}
```

To make a transference operation, the user need to give as parameters a list of accounts, the integer and the fractional values of the transference. In the accounts list, the head element must be the sender account and the tail must be the receivers. The user can make a transference from one account to one account or more (in this case, the transference amount is splitted equally by the receivers accounts. The return of this operations is a list of accounts updated by the transference. The elements order inside the list is the same order of the accounts list given as  operation input parameter. Usage examples are in following.

```elixir
iex> [joao, marcos] = Bank.transfer_money([joao, marcos], 4, 30)
[
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 0,
    integer_balance: 15,
    owner: "Joao"
  },
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 30,
    integer_balance: 4,
    owner: "Marcos"
  }
]
iex> [joao, marcos, marcelo] = Bank.transfer_money([joao, marcos, marcelo], 15, 0) 
[
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 0,
    integer_balance: 0,
    owner: "Joao"
  },
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 80,
    integer_balance: 11,
    owner: "Marcos"
  },
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 50,
    integer_balance: 7,
    owner: "Marcelo"
  }
]

```

An account must have the necessary amount to make the transference, otherwise a fail message will be displayed, and the method will return the unaltered account structs, as shown below

```elixir
iex> [joao, marcos, marcelo] = Bank.transfer_money([joao, marcos, marcelo], 15, 0)
You don't have enough money to make this transfer! Aborting Operation ...
[
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 0,
    integer_balance: 0,
    owner: "Joao"
  },
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 80,
    integer_balance: 11,
    owner: "Marcos"
  },
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 50,
    integer_balance: 7,
    owner: "Marcelo"
  }
]
```
The transference operation must receive as parameters accounts with same currency. Otherwise, an error message will be displayed and the method returns the unaltered value of the account structs.

```elixir
iex> [marcelo, uzumaki] = Bank.transfer_money([marcelo, uzumaki], 4, 10)          
All accounts need to be in the same currency to make a transfer
[
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 50,
    integer_balance: 7,
    owner: "Marcelo"
  },
  %AccountJPY{
    currency: "JPY",
    decimals: 0,
    fractionary_balance: 0,
    integer_balance: 0,
    owner: "Uzumaki"
  }
]
```

## Exchange money operation

The system also provides an operation to buy money from one currency to other currency. When the user buy money of other currency, the value is debited from his accounts  (so, the user must has the value in his account balance). Usage examples are shown below.

```elixir
iex> [yens, joao] = ExchangeAgency.buy_yens(joao, 20, 0)
You bought 524.6 yens
[
  524.6,
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 0,
    integer_balance: 280,
    owner: "Joao"
  }
]
```

The user can’t buy money from his own account currency. In this case, the operation
returns [0, unaltered_account]

```elixir
iex(4)> [reals, joao] = ExchangeAgency.buy_reals(joao, 20, 0)
You already has reals
[
  0,
  %AccountBRL{
    currency: "BRL",
    decimals: 2,
    fractionary_balance: 0,
    integer_balance: 280,
    owner: "Joao"
  }
]
```

