class CreateLines < ActiveRecord::Migration[5.2]
  def change
    create_table :lines do |t|
      t.text :buyer
      t.text :description
      t.float :unit_price, :precision => 8, :scale => 2
      t.integer :quantity
      t.float :total, :precision => 8, :scale => 2
      t.text :address
      t.text :supplier
      t.references :attachment, foreign_key: true

      t.timestamps
    end
  end
end
