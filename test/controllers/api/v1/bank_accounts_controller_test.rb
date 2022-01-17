require "test_helper"

module Api
  module V1
    class BankAccountsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @bank_account = bank_accounts(:one)
        @customer = @bank_account.customer
      end

      test "should list all banking_accounts from a customer" do
        get api_v1_customer_bank_accounts_url(@customer), as: :json
        assert_response :success
      end

      test "should create a bank_account for a customer" do
        assert_difference("BankAccount.count") do
          post api_v1_customer_bank_accounts_url(@customer),
            params: { customer_id: @customer.id,
              bank_account: { customer_id: @customer.id,
                              bank_code: 003,
                              agency_code: 12356,
                              account_number: 1212121 } }, as: :json
        end

        assert_response :created
      end

      test "should return a bank_account from a customer" do
        get api_v1_customer_bank_account_url(@customer, @bank_account), as: :json
        assert_response :success
      end

      test "should return 404 when customer doesn't exist" do
        customer = Customer.new
        customer.id = 0
        get api_v1_customer_bank_account_url(customer, @bank_account), as: :json
        assert_response :not_found
      end

      test "should return 404 when bank_account doesn't exist" do
        bank_account = BankAccount.new
        bank_account.id = 0
        get api_v1_customer_bank_account_url(@customer, bank_account), as: :json
        assert_response :not_found
      end

      test "should update a bank_account from a customer" do
        patch api_v1_customer_bank_account_url(@customer, @bank_account),
          params: {
            bank_account: { customer_id: @customer.id,
                            bank_code: @bank_account.bank_code,
                            agency_code: @bank_account.agency_code,
                            account_number: @bank_account.account_number } }, as: :json
        assert_response :success
      end

      test "should delete a bank_account from a customer" do
        assert_difference("BankAccount.count", -1) do
          delete api_v1_customer_bank_account_url(@customer, @bank_account), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
