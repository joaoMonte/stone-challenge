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

  test "Make a credit on a BRL account" do
    joao = AccountFactory.factory("BRL", "Joao")
    joao = Bank.credit_account(joao, 30, 20)
    assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
  end

  test "Make a credit on a CNY account" do
    xing = AccountFactory.factory("CNY", "Xing")
    xing = Bank.credit_account(xing, 30, 2)
    assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
  end

  test "Make a credit on a JPY account" do
    uzumaki = AccountFactory.factory("JPY", "Uzumaki")
    uzumaki = Bank.credit_account(uzumaki, 30, 0)
    assert uzumaki == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
  end

  test "Make a credit on a JOD account" do
    omar = AccountFactory.factory("JOD", "Omar")
    omar = Bank.credit_account(omar, 30, 300)
    assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
  end

  test "Make a credit with carry on a BRL account" do
    joao = %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
    joao = Bank.credit_account(joao, 10, 90)
    assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 41, fractionary_balance: 10, currency: "BRL"}
  end

  test "Make a credit with carry on a CNY account" do
    xing = %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
    xing = Bank.credit_account(xing, 20, 9)
    assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 51, fractionary_balance: 1, currency: "CNY"}
  end

  test "Make a credit with carry on a JOD account" do
    omar = %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
    omar = Bank.credit_account(omar, 30, 900)
    assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 61, fractionary_balance: 200, currency: "JOD"}
  end



  test "Make a debit on a BRL account" do
    joao = %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
    joao = Bank.debit_account(joao, 20, 10)
    assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 10, fractionary_balance: 10, currency: "BRL"}
  end

  test "Make a debit on a CNY account" do
    xing = %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
    xing = Bank.debit_account(xing, 10, 1)
    assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 20, fractionary_balance: 1, currency: "CNY"}
  end

  test "Make a debit on a JPY account" do
    uzumaki = %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
    uzumaki = Bank.debit_account(uzumaki, 10, 0)
    assert uzumaki == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 20, fractionary_balance: 0, currency: "JPY"}
  end

  test "Make a debit on a JOD account" do
    omar = %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
    omar = Bank.debit_account(omar, 10, 150)
    assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 20, fractionary_balance: 150, currency: "JOD"}
  end


end
