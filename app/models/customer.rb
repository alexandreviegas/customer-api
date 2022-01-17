class Customer < ApplicationRecord
  # customers can have many bank accounts
  has_many :bank_accounts, dependent: :destroy

  # required fields
  validates_presence_of :legal_name, :phone_number, :address, :city, :state, :declared_revenues

  # it's not allowed to have two customers with the same LegalName in same state
  validates_uniqueness_of :legal_name, scope: :state
end
