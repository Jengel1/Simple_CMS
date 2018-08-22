class Page < ApplicationRecord

    # acts_as_list :scope => :subject

    belongs_to :subject
    has_many :sections
    has_and_belongs_to_many :admin_users

    scope :visible, -> { where(:visible => true)}
    scope :invisible, -> { where(:visible => false)}
    scope :sorted, -> {order(:position => :asc)}
    scope :newest_first, -> {order("created_at DESC")}
    scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

    # validates_presence_of :name
    # validates_length_of :name, :maximum => 255
    # validates_presence_of :permalink
    # validates_length_of :permalink, :within => 3..255
    # validates_uniqueness_of :permalink

    validates :name, :presence => true, :length => { :maximum => 255 }
    validates :permalink, :presence => true, :length => { :within => 3..255 }, :uniqueness => true

end
