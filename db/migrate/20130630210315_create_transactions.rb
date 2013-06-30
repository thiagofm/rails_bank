class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :credit_card_id
      t.decimal :value
      t.string :store_code

      t.timestamps
    end

    add_index :transactions, :credit_card_id, unique: true
  end
end
