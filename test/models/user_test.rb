require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username: 'test_user', email: 'example@gmail.com', password: '111111')
  end
  test "User should be valid" do
    assert @user.valid?
  end
  test "username should be precense" do
    @user.username = " "
    assert_not @user.valid?
  end
  
  test "username should not be too long" do
    @user.username = "a" * 41
    assert_not @user.valid?
  end
  
  test "username should not be too short" do
    @user.username = "aa"
    assert_not @user.valid?
  end
  
  test "username should be unique" do
    user_name = @user.dup
    user_name.username = @user.username
    @user.save
    assert_not user_name.valid?
  end
  
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  
  test "email should be within bounds" do
    @user.email = "a" * 101 + "@example.com"
    assert_not @user.valid?
  end  
  
  test "email should be unique" do
    dum_user = @user.dup
    dum_user.email = @user.email.upcase
    @user.save
    assert_not dum_user.valid?
  end
  
  test "email should accept valid" do
    vali_addresses = %w[user@eee.com R_TDD-Ds@eee.hello.org user@example.com first.last@eee.au laura+joe@monk.cm]
    vali_addresses.each do |va|
      @user.email = va
      assert @user.valid?, '#{va.inspect} should be valid'
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example ee@i_am_.com foo@ee+aar.com]
    invalid_addresses.each do |iv|
      @user.email = iv
      assert_not @user.valid?, '#{iv.inspect} should be invalid'
    end
  end
end
