class CreateSellers < ActiveRecord::Migration[6.1]
  def change
    create_table :sellers do |t|
      t.string :name
      t.text :address

      t.timestamps
    end
  end
end
