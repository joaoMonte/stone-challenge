defmodule ExchangeAgency do
  @moduledoc """
  Module which encapsulate the currency exchange operation.
  It deals with bank accounts.
  The module has a storage of constants for each conversion allowed by the system.
  This constants are used in the methods. Each conversion is a list. At this list, the first
  element is the integer value and the second is the fractionary part.
  """

  @jpy_to_cny 2
  @jpy_to_brl 1
  @jpy_to_jod 3
  @brl_to_jpy 4
  @brl_to_cny 5
  @brl_to_jod 6
  @cny_to_brl 7
  @cny_to_jpy 8
  @cny_to_jod 9
  @jod_to_brl 10
  @jod_to_cny 11
  @jod_to_jpy 12

  def inv_pot_10(value) do
    :math.pow(10, (-1) * value) |> round
  end

  def apply_conversion(int_value, fract_value, conv, dec) do
    value = (int_value * conv) + (fract_value * inv_pot_10(dec) * conv)
    "You bought " <> to_string(value)
  end


  def buy_yens(account, int_value, fract_value) do
    cond do
      account.currency == "BRL" ->
        IO.puts apply_conversion(int_value, fract_value, @brl_to_jpy, account.decimals) <> " yens"
      account.currency == "JOD" ->
        IO.puts apply_conversion(int_value, fract_value, @jod_to_jpy, account.decimals) <> " yens"
      account.currency == "CNY" ->
        IO.puts apply_conversion(int_value, fract_value, @cny_to_jpy, account.decimals) <> " yens"
      account.currency == "JPY" ->
        IO.puts "You already has yens"
    end
  end

  def buy_jordanian_dinar(account, int_value, fract_value) do
    cond do
      account.currency == "BRL" ->
        IO.puts apply_conversion(int_value, fract_value, @brl_to_jod, account.decimals) <> " jordanian dinars"
      account.currency == "JOD" ->
        IO.puts "You already has jordanian dinars"
      account.currency == "CNY" ->
        IO.puts apply_conversion(int_value, fract_value, @cny_to_jod, account.decimals) <> " jordanian dinars"
      account.currency == "JPY" ->
        IO.puts apply_conversion(int_value, fract_value, @jpy_to_jod, account.decimals) <> " jordanian dinars"
    end
  end

  def buy_reals(account, int_value, fract_value) do
    cond do
      account.currency == "BRL" ->
        IO.puts "You already has reals"
      account.currency == "JOD" ->
        IO.puts apply_conversion(int_value, fract_value, @jod_to_brl, account.decimals) <> " reals"
      account.currency == "CNY" ->
        IO.puts apply_conversion(int_value, fract_value, @cny_to_brl, account.decimals) <> " reals"
      account.currency == "JPY" ->
        IO.puts apply_conversion(int_value, fract_value, @jpy_to_brl, account.decimals) <> " reals"
    end
  end

  def buy_renminbis(account, int_value, fract_value) do
    cond do
      account.currency == "BRL" ->
        IO.puts apply_conversion(int_value, fract_value, @brl_to_cny, account.decimals) <> " renminbis"
      account.currency == "JOD" ->
        IO.puts apply_conversion(int_value, fract_value, @jod_to_cny, account.decimals) <> " renminbis"
      account.currency == "CNY" ->
        IO.puts "You already has renminbis"
      account.currency == "JPY" ->
        IO.puts apply_conversion(int_value, fract_value, @jpy_to_cny, account.decimals) <> " renminbis"
    end
  end


end
