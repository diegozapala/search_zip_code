class City < ApplicationRecord

  belongs_to :state

  has_many :addresses, dependent: :delete_all

  validates :external_id, :name, presence: true
  validates :external_id, uniqueness: true

end
