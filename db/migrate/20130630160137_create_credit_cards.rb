class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.string :number, unique: true
      t.string :cvv
      t.decimal :outstanding_balance
      t.decimal :available_balance

      t.timestamps
    end
    add_index :credit_cards, :number, unique: true
  end
end
