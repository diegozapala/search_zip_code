class Address < ApplicationRecord

  belongs_to :state
  belongs_to :city

  has_many :user_addresses, dependent: :delete_all
  has_many :users, through: :user_addresses

  validates :neighborhood, :street, :zip_code, presence: true
  validates :zip_code, uniqueness: true

  def full_address
    "#{street} - #{neighborhood}, #{city.name} - #{state.uf}, #{zip_code}"
  end

end
