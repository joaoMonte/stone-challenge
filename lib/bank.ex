defmodule Bank do
  @moduledoc """
  Bank module which encapsulate methods to transfer and manage accounts
  """

  @doc """
  Debit  and credit functions, which are called during the transfer function
  They return the updated struct after the operation.
  """
  def debit_account(account, integer_value, fractionary_value) do
    if account.fractionary_balance < fractionary_value do
      account = %{account | integer_balance: account.integer_balance - integer_value - 1}
      %{account | fractionary_balance: account.fractionary_balance - fractionary_value + 100}

    else
      account = %{account | integer_balance: account.integer_balance - integer_value}
      %{account | fractionary_balance: account.fractionary_balance - fractionary_value}
    end
  end

  def credit_account(account, integer_value, fractionary_value) do

    if account.fractionary_balance + fractionary_value > 100 do
      account = %{account | fractionary_balance: account.fractionary_balance + fractionary_value}
      account = %{account | integer_balance: account.integer_balance + div(account.fractionary_balance, 100)}
      account = %{account | fractionary_balance: rem(account.fractionary_balance, 100)}
      %{account | integer_balance: account.integer_balance + integer_value}
    else
      account = %{account | fractionary_balance: account.fractionary_balance + fractionary_value}
      %{account | integer_balance: account.integer_balance + integer_value}
    end
  end

  @doc """
  The two forms cover the transference to one or more accounts. They return a list containing the
  updated accounts. The head of the list is the sender account and the tail are/is the receivers
  """
  def transfer_money(sender, receiver, integer_value, fractionary_value) do
    output = []
    cond do
      sender[:integer_balance] == integer_value ->
        if sender[:fractionary_balance] < fractionary_value do
          IO.puts "You don't have enough money to make this transfer! Aborting Operation ..."
        else
            debit_account(sender, integer_value, fractionary_value)
            credit_account(receiver, integer_value, fractionary_value)
        end
      sender[:integer_balance] < integer_value ->
        IO.puts "You don't have enough money to make this transfer! Aborting Operation ..."
      true ->
        debit_account(sender, integer_value, fractionary_value)
        credit_account(receiver, integer_value, fractionary_value)
    end
  end

  def transfer_money(sender, [first_receiver | other_receivers], value) do
    IO.puts "Transfering money from " <> first_receiver <> " to many accounts"
  end

end
