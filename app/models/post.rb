class Post < ActiveRecord::Base
  belongs_to :user
  # belongs_to :category
  has_many :likes
  has_many :taggings
  has_many :tags, through: :taggings
  before_create :get_video_id
  
  #set default for some fields
  after_initialize :init
  
  scope :populare, ->{ where(status: 'published').order(updated_at: :asc).limit(10) }
  scope :relate, ->(id, tag_ids){ joins(:taggings).where(taggings: { tag_id: tag_ids }).group(id).where.not(id: id).limit(10) }
  scope :most_viewd, ->{where(status: 'published').order(viewed: :desc).limit(10)}
  scope :published, ->{ where(status: 'published').order(updated_at: :desc) }
  scope :post_draf, ->{ where(status: nil).order(created_at: :desc) }
  scope :most_liked, ->{ where(status: 'published').order(liked: :desc).limit(10) }
  scope :recent, ->{ order("created_at desc") }
  scope :list_by_user, ->(user_id){ where(user_id: user_id) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :video_id, presence: true
  
  def get_video_id
    @regex = /youtube.com.*(?:\/|v=)([^&$]+)/
    @video = self.video_id.match(@regex)
    
    if @video
      self.video_id = @video[1]
    else
      false 
    end
  end
  
  def init
    self.liked || 0
    self.disliked || 0
  end
  
  #update viewed
  
  def update_viewed
    old_viewed = (self.viewed ? self.viewed : 0)
    self.update_attribute(:viewed, old_viewed + 1)
  end
  
  def update_like(action = false)
    self.record_timestamps = false
    liked = (self.liked ? self.liked + 1 : 1)
    if action
      update_attribute(:liked, liked)
    else
      dislike = (self.disliked && self.disliked > 0 ? self.disliked - 1 : 0)
      update_attributes(:liked => liked, :disliked => dislike)
    end
    self.record_timestamps = false
  end
  
  def update_dislike(action = false)
    self.record_timestamps = false
    dislike = (self.disliked ? self.disliked + 1 : 1)
    if action
      update_attribute(:disliked, dislike)
    else
      liked = (self.liked && self.liked > 0 ? self.liked - 1 : 0)
      update_attributes(:liked => liked, :disliked => dislike)
    end
    self.record_timestamps = false
  end
  # tag function
  
  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
  
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end