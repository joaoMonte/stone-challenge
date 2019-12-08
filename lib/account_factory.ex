defmodule AccountFactory do
  @moduledoc """
  Module which acts as a factory to create different types of accounts.
  This factory can create accounts of currencies: BRL, JOD, JPY and CNY.
  """

  @doc """
  The factory method receives as parameters the native currency of the account and the
  name of the account owner.
  """
  def factory(currency, name) do
    cond do
      currency == "BRL" ->
        %AccountBRL{owner: name}
      currency == "CNY" ->
        %AccountCNY{owner: name}
      currency == "JOD" ->
        %AccountJOD{owner: name}
      currency == "JPY" ->
        %AccountJPY{owner: name}
      true ->
        IO.puts "Invalid currency!"
    end
  end
end
