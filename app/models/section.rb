class Section < ApplicationRecord

    # belongs_to :page
    has_many :section_edits
    has_many :admin_users, :through => :section_edits #traverses rich m:n relationship

    scope :visible, -> { where(:visible => true)}
    scope :invisible, -> { where(:visible => false)}
    scope :sorted, -> {order(:position => :asc)}
    scope :newest_first, -> {order("created_at DESC")}
    # scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

    CONTENT_TYPES = ['text', 'HTML']

    # validates_presence_of :name
    # validates_length_of :name, :maximum => 255
    validates :name, :presence => true, :length => { :maximum => 255 }
    validates_inclusion_of :content_type, :in => CONTENT_TYPES, :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
    validates_presence_of :content

end
