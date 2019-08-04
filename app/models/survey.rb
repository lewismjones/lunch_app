class Survey < ApplicationRecord
  validates :participant, presence: true
  validates :response, presence: {message: "You must choose at least one restaurant bro!"}
  scope :today, -> { where('DATE(created_at) = ?', Date.today)}

  def self.result_participants
    participants = []
    Survey.today.map { |x|  participants << x[:participant] }
    participants.join(", ").titleize
  end

  def self.result_winner
    candidates = []
    Survey.today.map { |x|  candidates << x[:response].split(",") }
    candidates = candidates.flatten.group_by(&:itself).transform_values(&:count)
    result = candidates.select {|k,v| v == candidates.values.max}.keys.sample.to_i
    return [Restaurant.find(result).name, candidates.values.max]
  end

  def self.concensus?
    Survey.result_winner.last == Survey.today.count
  end
end
