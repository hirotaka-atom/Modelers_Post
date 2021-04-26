class BravoTag < ApplicationRecord
  validates :name, presence:true, uniqueness: true, length: {maximum: 20}

  has_many :bravos
end
