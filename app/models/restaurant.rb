class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :distance, presence: true

end
