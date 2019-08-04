class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :distance, presence: true
  validate :beings_with_http
  scope :alpha_sort, -> {order 'name'}
  scope :brunch, -> {where(brunch: true).order('name')}
  scope :drinks, -> {where(drinks: true).order('name')}
  scope :distance, -> {order 'distance', 'name' }

  def beings_with_http
    if website.present? && !( website.start_with?("http://") || website.start_with?("https://") )
      errors.add(:website, "must begin with http:// or https://")
    end
  end
end
