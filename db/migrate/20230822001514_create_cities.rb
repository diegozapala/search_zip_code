class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.references :state, foreign_key: true, index: true
      t.string     :external_id
      t.string     :name

      t.timestamps
    end
  end
end
