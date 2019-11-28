defmodule Bank do
  @moduledoc """
  Bank module which encapsulate methods to transfer and manage accounts
  """

  @doc """
  The two forms cover the transference to one or more accounts
  """
  def transfer_money(sender, receiver, value) do
    IO.puts "Transfering money from " <> receiver <> " to " <> sender
  end

  def transfer_money(sender, [first_receiver | other_receivers], value) do
    IO.puts "Transfering money from " <> receiver <> " to many accounts"
  end

end
