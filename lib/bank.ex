defmodule Bank do
  @moduledoc """
  Bank module which encapsulate methods to transfer and manage accounts
  """

  @doc """
  The two forms cover the transference to one or more accounts
  """
  def debit_account(account, integer_value, fractionary_value) do
    IO.puts "Account debited"
  end

  def credit_account(account, integer_value, fractionary_value) do
    IO.puts "Account credited"
  end

  def transfer_money(sender, receiver, integer_value, fractionary_value) do
    cond do
      sender[:integer_balance] == integer_value ->
        cond do
          sender[:fractionary_balance] < fractionary_value ->
            IO.puts "You don't have enough money to make this transfer! Aborting Operation ..."
          true ->
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
    IO.puts "Transfering money from " <> receiver <> " to many accounts"
  end

end
