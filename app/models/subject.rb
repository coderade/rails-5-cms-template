class Subject < ApplicationRecord

  # testing One-to-one

  has_one :page

  scope :visible, -> {where(:visible =>true)}
  scope :invisible, -> {where(:visible =>false)}
  scope :sorted, -> {order(:position=> :asc)}
  scope :newest_first, -> {order(:created_at=> :desc)}

  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}


end
