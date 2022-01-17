require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "should not save a customer without legal_name" do
    @customer = customers(:cliente_1)
    @customer.legal_name = nil
    assert_not @customer.valid?
    assert_includes @customer.errors.messages[:legal_name], "can't be blank"
  end

  test "phone_number should be numeric" do
    @customer = customers(:cliente_1)
    @customer.phone_number = '(99) 98765-4321'
    assert_not @customer.valid?
    assert_includes @customer.errors.messages[:phone_number], 'is not a number'
  end

  test "postal_code should be numeric" do
    @customer = customers(:cliente_1)
    @customer.postal_code = '12345-678'
    assert_not @customer.valid?
    assert_includes @customer.errors.messages[:postal_code], 'is not a number'
  end

  test "should not save a customer with same legal_name on same state" do
    customer1 = customers(:cliente_1).dup
    customer1.legal_name = 'Cliente XPTO'
    customer1.state = 'PA'
    customer1.save

    customer2 = customers(:cliente_2).dup
    customer2.legal_name = 'Cliente XPTO'
    customer2.state = 'SP'
    assert customer2.save

    customer3 = customers(:cliente_1).dup
    customer3.legal_name = 'Cliente XPTO'
    customer3.state = 'PA'
    assert_not customer3.valid?
    assert_includes customer3.errors.messages[:legal_name], 'has already been taken'
  end
end
