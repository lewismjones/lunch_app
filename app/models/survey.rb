class Survey < ApplicationRecord
  validates :participant, presence: {message: "can't be blank, ya dingus!"}
  validate :response_more_than_three?
  validates :post_lunch, inclusion: { in: [ true, false ], message: "question must be answered!" }
  scope :today, -> { where('DATE(created_at) = ?', Date.today)}
  scope :post_lunch, -> { where(post_lunch: true)}

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

  def response_more_than_three?
    if response.nil? || response&.split(",").count < 3
      errors.add(:response, "Pick a few places. (That’s three, Chump.)")
    end
  end

end
