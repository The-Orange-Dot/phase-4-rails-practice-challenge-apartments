class Tenant < ApplicationRecord
  has_many :leases, dependent: :destroy
  has_many :tenants, through: :leases, dependent: :destroy

  validates :age, numericality: {greater_than_or_equal_to: 18}
  validates :name, presence: true

end
