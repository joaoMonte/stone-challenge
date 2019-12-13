defmodule StoneChallengeTest do
  use ExUnit.Case
  doctest StoneChallenge

  describe "Creation of a " do
    test "BRL account" do
      assert AccountFactory.factory("BRL", "Joao") == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 0, fractionary_balance: 0, currency: "BRL"}
    end

    test "CNY account" do
      assert AccountFactory.factory("CNY", "Xing") == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 0, fractionary_balance: 0, currency: "CNY"}
    end

    test "JPY account" do
      assert AccountFactory.factory("JPY", "Uzumaki") == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 0, fractionary_balance: 0, currency: "JPY"}
    end

    test "JOD account" do
      assert AccountFactory.factory("JOD", "Omar") == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 0, fractionary_balance: 0, currency: "JOD"}
    end
  end

  describe "Make a credit on a " do
    test "BRL account" do
      joao = AccountFactory.factory("BRL", "Joao")
      joao = Bank.credit_account(joao, 30, 20)
      assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
    end

    test "CNY account" do
      xing = AccountFactory.factory("CNY", "Xing")
      xing = Bank.credit_account(xing, 30, 2)
      assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
    end

    test "JPY account" do
      uzumaki = AccountFactory.factory("JPY", "Uzumaki")
      uzumaki = Bank.credit_account(uzumaki, 30, 0)
      assert uzumaki == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
    end

    test "JOD account" do
      omar = AccountFactory.factory("JOD", "Omar")
      omar = Bank.credit_account(omar, 30, 300)
      assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
    end
  end

  describe "Make a credit with carry on a " do
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
  end


  describe "Make a debit on a " do
    test "BRL account" do
      joao = %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
      joao = Bank.debit_account(joao, 20, 10)
      assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 10, fractionary_balance: 10, currency: "BRL"}
    end

    test "CNY account" do
      xing = %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
      xing = Bank.debit_account(xing, 10, 1)
      assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 20, fractionary_balance: 1, currency: "CNY"}
    end

    test "JPY account" do
      uzumaki = %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
      uzumaki = Bank.debit_account(uzumaki, 10, 0)
      assert uzumaki == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 20, fractionary_balance: 0, currency: "JPY"}
    end

    test "JOD account" do
      omar = %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
      omar = Bank.debit_account(omar, 10, 150)
      assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 20, fractionary_balance: 150, currency: "JOD"}
    end
  end

  describe "Make a invalid debit on a " do
    test "BRL account" do
      joao = %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
      joao = Bank.debit_account(joao, 40, 10)
      assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
    end

    test "CNY account" do
      xing = %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
      xing = Bank.debit_account(xing, 40, 1)
      assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
    end

    test "JPY account" do
      uzumaki = %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
      uzumaki = Bank.debit_account(uzumaki, 40, 0)
      assert uzumaki == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
    end

    test "JOD account" do
      omar = %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
      omar = Bank.debit_account(omar, 40, 150)
      assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
    end
  end
  describe "Make a debit with carry on a " do
    test "BRL account" do
      joao = %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
      joao = Bank.debit_account(joao, 20, 50)
      assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 9, fractionary_balance: 70, currency: "BRL"}
    end

    test "CNY account" do
      xing = %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 2, currency: "CNY"}
      xing = Bank.debit_account(xing, 10, 5)
      assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 19, fractionary_balance: 7, currency: "CNY"}
    end

    test "JOD account" do
      omar = %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
      omar = Bank.debit_account(omar, 10, 450)
      assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 19, fractionary_balance: 850, currency: "JOD"}
    end
  end

  describe "Make a transference from one account to one account, which these accounts are " do
    test "JOD accounts" do
      omar = %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
      yosef = AccountFactory.factory("JOD", "Yosef")
      [omar, yosef] = Bank.transfer_money([omar, yosef], 10, 200)
      assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 20, fractionary_balance: 100, currency: "JOD"}
      assert yosef == %AccountJOD{owner: "Yosef", decimals: 3, integer_balance: 10, fractionary_balance: 200, currency: "JOD"}
    end

    test "BRL accounts" do
      joao = %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
      marcos = AccountFactory.factory("BRL", "Marcos")
      [joao, marcos] = Bank.transfer_money([joao, marcos], 10, 20)
      assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 20, fractionary_balance: 0, currency: "BRL"}
      assert marcos == %AccountBRL{owner: "Marcos", decimals: 2, integer_balance: 10, fractionary_balance: 20, currency: "BRL"}
    end

    test "JPY accounts" do
      uzumaki = %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
      uchiha = AccountFactory.factory("JPY", "Uchiha")
      [uzumaki, uchiha] = Bank.transfer_money([uzumaki, uchiha], 10, 0)
      assert uzumaki == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 20, fractionary_balance: 0, currency: "JPY"}
      assert uchiha == %AccountJPY{owner: "Uchiha", decimals: 0, integer_balance: 10, fractionary_balance: 0, currency: "JPY"}
    end

    test "CNY accounts" do
      xing = %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 6, currency: "CNY"}
      xang = AccountFactory.factory("CNY", "Xang")
      [xing, xang] = Bank.transfer_money([xing, xang], 10, 2)
      assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 20, fractionary_balance: 4, currency: "CNY"}
      assert xang == %AccountCNY{owner: "Xang", decimals: 1, integer_balance: 10, fractionary_balance: 2, currency: "CNY"}
    end
  end

  describe "Make a transference from one account to 2 accounts, which these accounts are " do
    test "JOD accounts" do
      omar = %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 30, fractionary_balance: 300, currency: "JOD"}
      yosef = AccountFactory.factory("JOD", "Yosef")
      zaid = AccountFactory.factory("JOD", "Zaid")
      [omar, yosef, zaid] = Bank.transfer_money([omar, yosef, zaid], 10, 200)
      assert omar == %AccountJOD{owner: "Omar", decimals: 3, integer_balance: 20, fractionary_balance: 100, currency: "JOD"}
      assert yosef == %AccountJOD{owner: "Yosef", decimals: 3, integer_balance: 5, fractionary_balance: 100, currency: "JOD"}
      assert zaid == %AccountJOD{owner: "Zaid", decimals: 3, integer_balance: 5, fractionary_balance: 100, currency: "JOD"}
    end

    test "BRL accounts" do
      joao = %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
      marcos = AccountFactory.factory("BRL", "Marcos")
      renato = AccountFactory.factory("BRL", "Renato")
      [joao, marcos, renato] = Bank.transfer_money([joao, marcos, renato], 10, 20)
      assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 20, fractionary_balance: 0, currency: "BRL"}
      assert marcos == %AccountBRL{owner: "Marcos", decimals: 2, integer_balance: 5, fractionary_balance: 10, currency: "BRL"}
      assert renato == %AccountBRL{owner: "Renato", decimals: 2, integer_balance: 5, fractionary_balance: 10, currency: "BRL"}
    end

    test "JPY accounts" do
      uzumaki = %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 30, fractionary_balance: 0, currency: "JPY"}
      uchiha = AccountFactory.factory("JPY", "Uchiha")
      haruno = AccountFactory.factory("JPY", "Haruno")
      [uzumaki, uchiha, haruno] = Bank.transfer_money([uzumaki, uchiha, haruno], 12, 0)
      assert uzumaki == %AccountJPY{owner: "Uzumaki", decimals: 0, integer_balance: 18, fractionary_balance: 0, currency: "JPY"}
      assert uchiha == %AccountJPY{owner: "Uchiha", decimals: 0, integer_balance: 6, fractionary_balance: 0, currency: "JPY"}
      assert haruno == %AccountJPY{owner: "Haruno", decimals: 0, integer_balance: 6, fractionary_balance: 0, currency: "JPY"}
    end

    test "CNY accounts" do
      xing = %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 30, fractionary_balance: 6, currency: "CNY"}
      xang = AccountFactory.factory("CNY", "Xang")
      xeng = AccountFactory.factory("CNY", "Xeng")
      [xing, xang, xeng] = Bank.transfer_money([xing, xang, xeng], 18, 6)
      assert xing == %AccountCNY{owner: "Xing", decimals: 1, integer_balance: 12, fractionary_balance: 0, currency: "CNY"}
      assert xang == %AccountCNY{owner: "Xang", decimals: 1, integer_balance: 9, fractionary_balance: 3, currency: "CNY"}
      assert xang == %AccountCNY{owner: "Xang", decimals: 1, integer_balance: 9, fractionary_balance: 3, currency: "CNY"}
    end
  end

  describe "Try an invalid transference where " do
    test "the sender account dont has enough money" do
      joao = AccountFactory.factory("BRL", "Joao")
      marcos = AccountFactory.factory("BRL", "Marcos")
      [joao, marcos] = Bank.transfer_money([joao, marcos], 10, 20)
      assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 0, fractionary_balance: 0, currency: "BRL"}
      assert marcos == %AccountBRL{owner: "Marcos", decimals: 2, integer_balance: 0, fractionary_balance: 0, currency: "BRL"}
    end

    test "the accounts have different currencies" do
      joao = %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
      uchiha = AccountFactory.factory("JPY", "Uchiha")
      [joao, uchiha] = Bank.transfer_money([joao, uchiha], 10, 20)
      assert joao == %AccountBRL{owner: "Joao", decimals: 2, integer_balance: 30, fractionary_balance: 20, currency: "BRL"}
      assert uchiha == %AccountJPY{owner: "Uchiha", decimals: 0, integer_balance: 0, fractionary_balance: 0, currency: "JPY"}
    end
  end


end
