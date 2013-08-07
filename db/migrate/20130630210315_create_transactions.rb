class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.decimal :value
      t.string :store_code

      t.timestamps
    end
  end
end
