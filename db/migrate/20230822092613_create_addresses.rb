class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :state, foreign_key: true, index: true
      t.references :city, foreign_key: true, index: true
      t.string     :neighborhood
      t.string     :street
      t.string     :zip_code

      t.timestamps
    end
  end
end
