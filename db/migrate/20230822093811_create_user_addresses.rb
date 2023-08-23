class CreateUserAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_addresses do |t|
      t.references :user, foreign_key: true, index: true
      t.references :address, foreign_key: true, index: true

      t.timestamps
    end
  end
end
