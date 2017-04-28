class Subject < ApplicationRecord

  # acts_as_list

  has_many :pages

  scope :visible, -> {where(:visible =>true)}
  scope :invisible, -> {where(:visible =>false)}
  scope :sorted, -> {order(:position=> :asc)}
  scope :newest_first, -> {order(:created_at=> :desc)}

  scope :search, lambda {|query| where(['name LIKE ?', "%#{query}%"])}

  validates :name, :presence => true,
            :length => {:maximum => 255}
  validates_uniqueness_of :position
end
