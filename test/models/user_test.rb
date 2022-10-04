require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "JohnDoe", email: 'john@doe.com', password: "password" )
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = ""
    assert_not @user.valid?
  end

  test 'user email should be present' do
    @user.email = nil
    assert_not @user.valid?
  end

  test 'user password should be present' do
    @user.password = nil
    assert_not @user.valid?
  end

  test "username should be unique" do
    @user.save
    @user2 = User.new(username: "JohnDoe", email: "jd@doe.com", password:"newpassword")
    assert_not @user2.valid?
  end

  test "user email should be unique" do
    @user.save
    @user2 = User.new(username: "JamesDoe", email: "john@doe.com", password:"newpassword")
    assert_not @user2.valid?
  end

  test "username should not be too long" do
    @user.username = "j" * 26
    assert_not @user.valid?
  end
  
  test "username should not be too short" do
    @user.username = "j" * 2
    assert_not @user.valid?
  end

  test "user email should not be too long" do
    @user.email = "j" * 105 + "@doe.com"
    assert_not @user.valid?
  end

end