class Robot < ApplicationRecord
  belongs_to :product
  has_one :manufacturer, through: :product
  has_one :purchase

  validates :name, presence: true
  validates :in_stock, inclusion: { in: [ true, false ] }
  validates :product_id, presence: true

  before_validation :set_expected_date, on: :create

  def mark_received
    self.update_attribute(:in_stock, true)
  end

  def self.in_stock
    self.all.where(in_stock: true)
  end

  def self.on_order
    self.all.where(in_stock: false)
  end

  def past_due?
    return true if self.expected_date < Time.now  && !in_stock
    false
  end

  private
  def set_expected_date
    self.expected_date = Time.now + 21.days
  end

end
