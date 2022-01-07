require "test_helper"

module Api
  module V1
    class BankAccountsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @bank_account = bank_accounts(:one)
        @customer = @bank_account.customer
      end

      test "should get index" do
        get api_v1_customer_bank_accounts_url(@customer), as: :json
        assert_response :success
      end

      test "should create bank_account" do
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

      test "should show bank_account" do
        get api_v1_customer_bank_account_url(@customer, @bank_account), as: :json
        assert_response :success
      end

      test "should update bank_account" do
        patch api_v1_customer_bank_account_url(@customer, @bank_account),
          params: {
            bank_account: { customer_id: @customer.id,
                            bank_code: @bank_account.bank_code,
                            agency_code: @bank_account.agency_code,
                            account_number: @bank_account.account_number } }, as: :json
        assert_response :success
      end

      test "should destroy bank_account" do
        assert_difference("BankAccount.count", -1) do
          delete api_v1_customer_bank_account_url(@customer, @bank_account), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
