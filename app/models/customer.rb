class Customer < ApplicationRecord
  # customers can have many bank accounts
  has_many :bank_accounts, dependent: :destroy

  # required fields
  validates_presence_of :legal_name, :phone_number, :address, :city, :state, :declared_revenues

  validates_uniqueness_of :legal_name, scope: :state

  validates_associated :bank_accounts
end
