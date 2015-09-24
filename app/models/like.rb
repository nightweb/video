class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  
  validates_uniqueness_of :user, scope: :post
  # # scope :check_availiable, ->(user_id, post_id){ where("user_id = ? AND post_id = ?", user_id, post_id).first }
  def self.check_availiable(user_id, post_id)
    where("user_id = #{user_id} AND post_id=#{post_id}").first
  end
  
  # def self.update_like_action(user_id, post_id, action)
  #   like = check_availiable(user_id, post_id)
  #   if like
  #     if like.like
  #     like.update_attribute(:like, action)
  #   end
  # end
  # def self.like_action(user, post, action)
  #   like = check_availiable(user.id, post.id)
  #   if like
  #     if like.like && action == false
  #       post.update_dislike
  #     end
  #     if like.like == false && action == true
  #       post.update_like
  #     end
  #     like.update_attribute(:like, action)
  #   else
  #     create(user_id: user.id, post_id: post.id, like: action)
  #     if action
  #       post.update_like(true)
  #     else
  #       post.update_dislike(true)
  #     end
  #   end
  # end
  
end
