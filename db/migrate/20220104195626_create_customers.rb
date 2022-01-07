class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :legal_name, null: false
      t.string :phone_number, null: false
      t.string :address, null: false
      t.string :address_number, limit: 6
      t.string :complement
      t.string :neighbourhood, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :postal_code, null: false
      t.date :register_date, null: false
      t.decimal :declared_revenues, null: false

      t.timestamps
    end
  end
end
