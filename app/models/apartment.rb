class Apartment < ApplicationRecord
  has_many :leases, dependent: :destroy
  has_many :tenants, through: :leases, dependent: :destroy

  validates :number, numericality: {only_integer: true, message: "You can only input numbers for apartment numbers"}

end
