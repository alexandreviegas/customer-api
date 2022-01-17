require "test_helper"

module Api
  module V1
    class CustomersControllerTest < ActionDispatch::IntegrationTest
      setup do
        @customer = customers(:cliente_1)
        @customer.legal_name = "Test Customer"
      end

      test "should list all customers" do
        get api_v1_customers_url, as: :json
        assert_response :success
      end

      test "should create a customer" do
        assert_difference("Customer.count", 1, "Customer not created") do
          post api_v1_customers_url, params: {
            customer: {
              legal_name: @customer.legal_name,
              phone_number: @customer.phone_number,
              address: @customer.address,
              address_number: @customer.address_number,
              complement: @customer.complement,
              neighbourhood: @customer.neighbourhood,
              city: @customer.city,
              state: @customer.state,
              postal_code: @customer.postal_code,
              register_date: @customer.register_date,
              declared_revenues: @customer.declared_revenues} }, as: :json
        end

        assert_response :created
      end

      test "should return a customer" do
        get api_v1_customer_url(@customer), as: :json
        assert_response :success
      end

      test "should return 404 when customer doesn't exist" do
        customer = Customer.new
        customer.id = 0
        get api_v1_customer_url(customer), as: :json
        assert_response :missing
        assert_includes @response.body, "Couldn't find Customer with 'id'=0"
      end

      test "should update a customer" do
        patch api_v1_customer_url(@customer), params: {
          customer: {
            legal_name: @customer.legal_name,
            phone_number: @customer.phone_number,
            address: @customer.address,
            address_number: @customer.address_number,
            complement: @customer.complement,
            neighbourhood: @customer.neighbourhood,
            city: @customer.city,
            state: @customer.state,
            postal_code: @customer.postal_code,
            register_date: @customer.register_date,
            declared_revenues: @customer.declared_revenues} }, as: :json
        assert_response :success
      end

      test "should delete a customer" do
        assert_difference("Customer.count", -1) do
          delete api_v1_customer_url(@customer), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
