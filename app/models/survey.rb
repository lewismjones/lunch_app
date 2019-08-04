class Survey < ApplicationRecord
  validates :participant, presence: {message: "can't be blank, ya dingus!"}
  validates :response, presence: {message: "You must choose at least one restaurant bro!"}
  scope :today, -> { where('DATE(created_at) = ?', Date.today)}

  def self.result_participants
    participants = []
    Survey.today.map { |survey|  participants << survey[:participant] }
    participants.join(", ").titleize
  end

  def self.top_contenders
    candidates = []
    Survey.today.map { |survey|  candidates << survey[:response].split(",") }
    candidates = candidates.flatten.group_by(&:itself).transform_values(&:count)
    result = candidates.select {|k,v| v == candidates.values.max}.keys
    return [result, candidates.values.max]
  end

  def self.result_winner
    Restaurant.find(top_contenders.first.sample.to_i).name
  end

  def self.unanimous?
    Survey.top_contenders.last == Survey.today.count
  end
end
