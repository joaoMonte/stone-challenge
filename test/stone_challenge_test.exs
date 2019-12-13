defmodule StoneChallengeTest do
  use ExUnit.Case
  doctest StoneChallenge

  test "Creation of a BRL account" do
    assert AccountFactory.factory("BRL", "Joao") == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 0, fractionary_balance: 0, currency: "BRL"}
  end

  test "Creation of a CNY account" do
    assert AccountFactory.factory("CNY", "Xing") == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 0, fractionary_balance: 0, currency: "CNY"}
  end

  test "Creation of a JPY account" do
    assert AccountFactory.factory("JPY", "Uzumaki") == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 0, fractionary_balance: 0, currency: "JPY"}
  end

  test "Creation of a JOD account" do
    assert AccountFactory.factory("JOD", "Omar") == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 0, fractionary_balance: 0, currency: "JOD"}
  end

end
