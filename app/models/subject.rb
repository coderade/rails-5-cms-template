class Subject < ApplicationRecord

  has_many :pages

  scope :visible, -> {where(:visible =>true)}
  scope :invisible, -> {where(:visible =>false)}
  scope :sorted, -> {order(:position=> :asc)}
  scope :newest_first, -> {order(:created_at=> :desc)}

  scope :search, lambda {|query| where(['name LIKE ?', "%#{query}%"])}

  validates_presence_of :name
  validates_uniqueness_of :position
end
