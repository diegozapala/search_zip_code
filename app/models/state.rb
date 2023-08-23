class State < ApplicationRecord

  has_many :cities, dependent: :delete_all
  has_many :addresses, dependent: :delete_all

  validates :external_id, :uf, :name, presence: true
  validates :external_id, uniqueness: true

end
