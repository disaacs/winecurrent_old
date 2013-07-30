class Wine < ActiveRecord::Base
  has_many :reviews, :dependent => :destroy
  accepts_nested_attributes_for :reviews, :allow_destroy => true, :reject_if => lambda { |a| a[:review].blank? }
  
  validates :name, presence: true
  validates :lcbo, uniqueness: true
  
end
