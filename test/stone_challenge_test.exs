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

  test "Make an credit on a BRL account" do
    joao = AccountFactory.factory("BRL", "Joao")
    joao = Bank.credit_account(joao, 30, 20)
    assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
  end

  test "Make an credit on a CNY account" do
    xing = AccountFactory.factory("CNY", "Xing")
    xing = Bank.credit_account(xing, 30, 2)
    assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
  end

  test "Make an credit on a JPY account" do
    uzumaki = AccountFactory.factory("JPY", "Uzumaki")
    uzumaki = Bank.credit_account(uzumaki, 30, 0)
    assert uzumaki == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
  end

  test "Make an credit on a JOD account" do
    omar = AccountFactory.factory("JOD", "Omar")
    omar = Bank.credit_account(omar, 30, 300)
    assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
  end

end
