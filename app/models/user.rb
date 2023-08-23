class User < ApplicationRecord

  has_many :user_addresses, dependent: :delete_all
  has_many :addresses, through: :user_addresses

  has_secure_password

  validates_presence_of :email, :password_digest
  validates :name, :last_name, presence: true
  validates :email, uniqueness: true

  before_save :set_default_params

  scope :active,   -> () { where(active: true) }
  scope :inactive, -> () { where(active: false) }

  def set_default_params
    self.email = email.downcase.remove(" ")
  end

  def full_name
    "#{name} #{last_name}"
  end

  def name_initials
    "#{name[0]}#{last_name ? last_name[0] : ''}"
  end

end
