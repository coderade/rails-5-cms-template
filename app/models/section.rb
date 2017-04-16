class Section < ApplicationRecord

  has_many :section_edits
  has_many :admin_users, :through => :section_edits

  scope :visible, -> {where(:visible =>true)}
  scope :invisible, -> {where(:visible =>false)}
  scope :sorted, -> {order(:position=> :asc)}
  scope :newest_first, -> {order(:created_at=> :desc)}

  CONTENT_TYPES = %w(text HTML)

  validates :name, :presence => true,
            :length => {:maximum => 255}
  validates :content_type, :inclusion => {:in => CONTENT_TYPES,
                                          :message => "must be one of: #{CONTENT_TYPES.join(',')}"}
  validates_presence_of :content
  validates_uniqueness_of :position
end
