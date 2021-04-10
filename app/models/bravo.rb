class Bravo < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :bravo_tag
end
