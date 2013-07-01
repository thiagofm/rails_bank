class RemoveMisplacedIndex < ActiveRecord::Migration
  def up
    remove_index :transactions, :credit_card_id
  end

  def down
    add_index :transactions, :credit_card_id, unique: true
  end
end
