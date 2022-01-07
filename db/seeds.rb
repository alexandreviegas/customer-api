# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
Faker::Config.locale = 'pt-BR'

Customer.destroy_all

20.times do
  c = Customer.create(legal_name: Faker::Company.name,
                      phone_number: Faker::PhoneNumber.phone_number,
                      address: Faker::Address.street_name,
                      address_number: Faker::Address.building_number,
                      complement: Faker::Address.secondary_address,
                      neighbourhood: Faker::Address.community,
                      city: Faker::Address.city,
                      state: Faker::Address.state_abbr,
                      postal_code: Faker::Address.postcode,
                      register_date: Faker::Date.in_date_period(year: 2021),
                      declared_revenues: Faker::Number.decimal(l_digits: 5))

  BankAccount.create(customer: c,
    bank_code: Faker::Number.number(digits: 3),
    agency_code: Faker::Number.number(digits: 4),
    account_number: Faker::Bank.account_number(digits: 6))
end
