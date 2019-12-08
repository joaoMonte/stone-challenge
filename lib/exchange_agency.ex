defmodule ExchangeAgency do
  @moduledoc """
  Module which encapsulate the currency exchange operation.
  It deals with bank accounts.
  The module has a storage of constants for each conversion allowed by the system.
  This constants are used in the methods. Each conversion is a list. At this list, the first
  element is the integer value and the second is the fractionary part.
  """

  @jpy_to_cny [1,2]
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


  def buy_yens(account, int_value, fract_value) do

  end

end
