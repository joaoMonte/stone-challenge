defmodule AccountJOD do
  @moduledoc """
  Struct which abstracts an account information.
  Each account has:
  - An owner, who can made transactions with it
  - The currency of the account balance
  - The balance, which is divided into integer and fractional parts
  - The number of decimals after comma
  - The structure for all account types are equal
  """

  defstruct [:owner, decimals: 3, integer_balance: 0, fractionary_balance: 0, currency: "JOD"]

end
