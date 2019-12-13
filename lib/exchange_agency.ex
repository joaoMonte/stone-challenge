defmodule ExchangeAgency do
  @moduledoc """
  Module which encapsulate the currency exchange operation.
  It deals with bank accounts.
  The module has a storage of constants for each conversion allowed by the system.
  This constants are used in the methods.
  """

  @jpy_to_cny 0.065
  @jpy_to_brl 0.038
  @jpy_to_jod 0.0065
  @brl_to_jpy 26.23
  @brl_to_cny 1.70
  @brl_to_jod 0.17
  @cny_to_brl 0.59
  @cny_to_jpy 15.44
  @cny_to_jod 0.10
  @jod_to_brl 5.84
  @jod_to_cny 9.92
  @jod_to_jpy 153.21

  def inv_pot_10(value) do
    round(:math.pow(10, (-1) * value))
  end

  @doc """
  The method apply_conversion multiply a value (divided into fract and integer parts) into
  by the necessary conversion value. its parameters also includes de number of decimals of the
  input currency (dec)
  """

  def apply_conversion(int_value, fract_value, conv, dec) do
    (int_value * conv) + (fract_value * inv_pot_10(dec) * conv)
  end

  @doc """
  All the buy currency methods works receiving a value (divided into int and fract parts),
  and an account. These methods returns a list which the head is the value bought by the
  user and the tail is the updated struct. When a user buy money from other currency, the
  value is debited from his account.
  """
  def buy_yens(account, int_value, fract_value) do
    cond do
      !Bank.check_account_balance(account, int_value, fract_value) ->
        IO.puts "You don't have this balance to buy yens"
        [0] ++ [account]
      account.currency == "BRL" ->
        value = apply_conversion(int_value, fract_value, @brl_to_jpy, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " yens"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "JOD" ->
        value = apply_conversion(int_value, fract_value, @jod_to_jpy, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " yens"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "CNY" ->
        value = apply_conversion(int_value, fract_value, @cny_to_jpy, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " yens"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "JPY" ->
        IO.puts "You already has yens"
        [0] ++ [account]
    end
  end

  def buy_jordanian_dinar(account, int_value, fract_value) do
    cond do
      !Bank.check_account_balance(account, int_value, fract_value) ->
        IO.puts "You don't have this balance to buy jordanian dinars"
        [0] ++ [account]
      account.currency == "BRL" ->
        value = apply_conversion(int_value, fract_value, @brl_to_jod, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " jordanian dinars"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "JOD" ->
        IO.puts "You already has jordanian dinars"
        [0] ++ [account]
      account.currency == "CNY" ->
        value = apply_conversion(int_value, fract_value, @cny_to_jod, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " jordanian dinars"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "JPY" ->
        value = apply_conversion(int_value, fract_value, @jpy_to_jod, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " jordanian dinars"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      end
  end

  def buy_reals(account, int_value, fract_value) do
    cond do
      !Bank.check_account_balance(account, int_value, fract_value) ->
        IO.puts "You don't have this balance to buy reals"
        [0] ++ [account]
      account.currency == "BRL" ->
        IO.puts "You already has reals"
        [0] ++ [account]
      account.currency == "JOD" ->
        value = apply_conversion(int_value, fract_value, @jod_to_brl, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " reals"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "CNY" ->
        value = apply_conversion(int_value, fract_value, @cny_to_brl, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " reals"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "JPY" ->
        value = apply_conversion(int_value, fract_value, @jpy_to_brl, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " reals"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
    end
  end

  def buy_renminbis(account, int_value, fract_value) do
    cond do
      !Bank.check_account_balance(account, int_value, fract_value) ->
        IO.puts "You don't have this balance to buy reals"
        [0] ++ [account]
      account.currency == "BRL" ->
        value = apply_conversion(int_value, fract_value, @brl_to_cny, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " renminbis"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "JOD" ->
        value = apply_conversion(int_value, fract_value, @jod_to_cny, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " renminbis"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
      account.currency == "CNY" ->
        IO.puts "You already has renminbis"
        [0] ++ [account]
      account.currency == "JPY" ->
        value = apply_conversion(int_value, fract_value, @jpy_to_cny, account.decimals)
        IO.puts "You bought " <> to_string(value) <> " renminbis"
        updated_account = Bank.debit_account(account, int_value, fract_value)
        [value] ++ [updated_account]
    end
  end

end
