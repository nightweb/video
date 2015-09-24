require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create(username: 'test', email: 'test@gmail.com', password: '111111')
    @post = @user.posts.new(title: 'test', description: 'hello', slug: 'slug', video_id: 'ta6beOvyhYE')
  end
  
  test "Post should be valid" do
    assert @post.valid?
  end
  
  test "Post title should be presence" do
    @post.title = " "
    assert_not @post.valid?
  end
  # test "Post slug should be presence" do
  #   @post.slug = " "
  #   assert_not @post.valid?
  # end
  test "Post video_id should be presence" do
    @post.video_id = " "
    assert_not @post.valid?
  end
  
  test "user_id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
end
