class BankAccount < ApplicationRecord
  belongs_to :customer

  # all fields are required
  validates_presence_of :customer_id, :bank_code, :agency_code, :account_number

  # bank_code and account number accepts numbers only
  validates_numericality_of :bank_code, :account_number

  # agency codes may have a number or a X char on check digit
  validates :agency_code, format: { with: /\A\d+X?\z/, message: "Agency check digit must be a number or a X"}

  # its not allowed to insert more than one account with the same bank, agency and number
  validates_uniqueness_of :account_number, scope: [:bank_code, :agency_code]
end
