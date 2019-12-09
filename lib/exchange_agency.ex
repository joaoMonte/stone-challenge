defmodule ExchangeAgency do
  @moduledoc """
  Module which encapsulate the currency exchange operation.
  It deals with bank accounts.
  The module has a storage of constants for each conversion allowed by the system.
  This constants are used in the methods. Each conversion is a list. At this list, the first
  element is the integer value and the second is the fractionary part.
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
