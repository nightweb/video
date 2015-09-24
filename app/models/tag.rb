class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings
  
  scope :find_tag_like, ->(name){ where("name like ?", "#{name}%") }
end
