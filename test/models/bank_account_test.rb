require "test_helper"

class BankAccountTest < ActiveSupport::TestCase
  setup do
    @customer = customers(:cliente_1)
  end

  test "should not save a bank account without customer" do
    @bank_account_nok = bank_accounts(:one)
    @bank_account_nok.customer = nil
    assert_not @bank_account_nok.save
  end

  test "bank code should be numeric" do
    @bank_account_nok = bank_accounts(:one)
    @bank_account_nok.bank_code = "12AD"
    assert_not @bank_account_nok.save
  end

  test "account number code should be numeric" do
    @bank_account_nok = bank_accounts(:one)
    @bank_account_nok.account_number = "1234t5t5"
    assert_not @bank_account_nok.save
  end

  test "should have only one bank account with same bank, agency and account number" do
    @bank_account_ok = BankAccount.new
    @bank_account_ok.customer = @customer
    @bank_account_ok.bank_code = '123'
    @bank_account_ok.agency_code = '1234'
    @bank_account_ok.account_number = '123456'
    @bank_account_ok.save

    @bank_account_nok = BankAccount.new
    @bank_account_nok.customer = @customer
    @bank_account_nok.bank_code = '123'
    @bank_account_nok.agency_code = '1234'
    @bank_account_nok.account_number = '123456'
    assert_not @bank_account_nok.save

  end

  test "agency should have a X or number on check digit" do
    @bank_account_ok1 = BankAccount.new
    @bank_account_ok1.customer = @customer
    @bank_account_ok1.bank_code = '1234'
    @bank_account_ok1.agency_code = '12346'
    @bank_account_ok1.account_number = '123467'
    assert @bank_account_ok1.save

    @bank_account_ok2 = BankAccount.new
    @bank_account_ok2.customer = @customer
    @bank_account_ok2.bank_code = '1234'
    @bank_account_ok2.agency_code = '12346X'
    @bank_account_ok2.account_number = '123467'
    assert @bank_account_ok2.save

    @bank_account_nok = BankAccount.new
    @bank_account_nok.customer = @customer
    @bank_account_nok.bank_code = '1234'
    @bank_account_nok.agency_code = '12346A'
    @bank_account_nok.account_number = '123467'
    assert_not @bank_account_nok.save

  end
end
