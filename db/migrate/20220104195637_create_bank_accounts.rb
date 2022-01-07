class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.references :customer, null: false
      t.string :bank_code, limit: 3, null: false
      t.string :agency_code, limit: 5, null: false
      t.string :account_number, null: false

      t.timestamps
    end

    add_foreign_key :bank_accounts, :customers, name: :fk_bank_accounts_customer_id
  end
end
