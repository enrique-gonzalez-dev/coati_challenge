class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.integer :total_items
      t.float :transaction_amount

      t.belongs_to :client
      t.belongs_to :seller
      t.belongs_to :product

      t.timestamps
    end
  end
end
