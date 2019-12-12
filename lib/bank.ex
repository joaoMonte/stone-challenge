defmodule Bank do
  @moduledoc """
  Bank module which encapsulate methods to transfer and manage accounts
  """

  @doc """
  The method check_account_balance check if an account has a balance equal or lesser than
  the integer and fractionary values given as parameters. This method will be used by other
  bank financial operations.
  """

  def check_account_balance(account, int_value, fract_value) do
    if account.integer_balance == int_value do
      account.fractionary_balance > fract_value
    else
      account.integer_balance > int_value
    end
  end


  @doc """
  Debit  and credit functions, which are called during the transfer function.
  Their parameters are: the account, the integer part and the fractionary
  part of the debit or credit.
  They return the updated struct after the operation.
  """

  def debit_account(account, int_value, fract_value) do
    if check_account_balance(account, int_value, fract_value) do
      if account.fractionary_balance < fract_value do
        dec = :math.pow(10, account.decimals) |> round
        account = %{account | integer_balance: account.integer_balance - int_value - 1}
        %{account | fractionary_balance: account.fractionary_balance - fract_value + dec}

      else
        account = %{account | integer_balance: account.integer_balance - int_value}
        %{account | fractionary_balance: account.fractionary_balance - fract_value}
      end
    else
      IO.puts "You can't debit this value from this account"
      %{account | currency: account.currency}
    end
  end

  def credit_account(account, int_value, fract_value) do
    dec = :math.pow(10, account.decimals) |> round
    if account.fractionary_balance + fract_value >= dec do
      dec = :math.pow(10, account.decimals) |> round
      account = %{account | fractionary_balance: account.fractionary_balance + fract_value}
      account = %{account | integer_balance: account.integer_balance + div(account.fractionary_balance, dec)}
      account = %{account | fractionary_balance: rem(account.fractionary_balance, dec)}
      %{account | integer_balance: account.integer_balance + int_value}
    else
      account = %{account | fractionary_balance: account.fractionary_balance + fract_value}
      %{account | integer_balance: account.integer_balance + int_value}
    end
  end

  @doc """
  The divide_transference method acts when a transference will be divided between accounts.
  Its parameters are: the number of accounts which the amount will be divided, the integer
  and the fractionary parts of the transference. The last parameter is the number os decimals
  of the account currency
  This method return a list whose first value is the integer result and the second is the
  fractionary result.
  """

  def divide_transference(num_accounts, int_value, fract_value, decimals) do
    dec = :math.pow(10, decimals) |> round
    int_result = div(int_value, num_accounts)
    fract_result = div(fract_value + rem(int_value, num_accounts) * dec, num_accounts)
    [int_result] ++ [fract_result]
  end


  @doc """
  The transference method can be applied to one or many receivers.
  Its first parameter is a list whose the head is the sender_account and the tail is the one or more
  receivers. The amount will be divided equally by the receivers. The other parameters are
  the integer and fractionary parts of the transference
  """

  def transfer_money( [sender | receivers], int_value, fract_value) do
    cond do
      Enum.any?(receivers, fn(account) -> account.currency != sender.currency end) ->
        IO.puts "All accounts need to be in the same currency to make a transfer"
        [sender | receivers]

      check_account_balance(sender, int_value, fract_value) ->
        num_accounts = Enum.count(receivers)
        decimals = sender.decimals
        [div_int_value, div_fract_value] = divide_transference(num_accounts, int_value, fract_value, decimals)
        sender = debit_account(sender, int_value, fract_value)
        [sender | Enum.map(receivers, fn(x) -> credit_account(x, div_int_value, div_fract_value) end)]

      true ->
        IO.puts "You don't have enough money to make this transfer! Aborting Operation ..."
        [sender | receivers]
    end
  end

end

