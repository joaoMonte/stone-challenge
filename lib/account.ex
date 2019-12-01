defmodule Account do
  @moduledoc """
  Struct which abstracts an account information.
  Each account has:
  - An owner, who can made transactions with it
  - The unique account number
  - The currency of the account balance
  - The balance, which is divided into integer and fractional parts
  """

  defstruct [:owner, :account_number, :currency, integer_balance: 0, fractionary_balance: 0]

end
