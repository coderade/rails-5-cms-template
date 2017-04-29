class Page < ApplicationRecord

  # acts_as_list :scope => :subject

  # disable belongs_to presence validation
  # belongs_to :subject, { :optional => true}
  belongs_to :subject

  #If we aren't using the Rails convention, we can define manually a join table name
  # has_and_belongs_to_many :admin_users, :join_table => 'pages_admin_users'
  has_many :sections
  has_and_belongs_to_many :admin_users

  scope :visible, -> {where(:visible =>true)}
  scope :invisible, -> {where(:visible =>false)}
  scope :sorted, -> {order(:position=> :asc)}
  scope :newest_first, -> {order(:created_at=> :desc)}

  validates :name, :presence => true,
            :length => {:maximum =>255 }

  validates :permalink, :presence => true,
            :length => {:within => 3..255 },
            :uniqueness => true
end
