class Usermetadatum < ActiveRecord::Base
  belongs_to :users
  belongs_to :posts
  
  validates_uniqueness_of :user, scope: :post
  
    #check vote are already
  def self.check_availiable(user, post)
    where("user_id =#{user.id} AND post_id=#{post.id}").first
  end

  def self.like_post(user, post)
      if self.check_availiable(user, post)
        update_attribute(like: true)
      else
        create(user_id: 1, post_id: 1, like: true)
      end
  end
  
  def self.dislike_post(user, post)
      if self.check_availiable(user, post)
        self.update_attribute(like: false)
      else
        self.create(user_id: user.id, post_id: post.id, like: false)
      end
  end
  
end
