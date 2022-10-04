require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "JohnDoe", email: 'john@doe.com', password: "weblogpass")
    @admin_user = User.create(username: "admmindoe", email: "admin@example.com",password: "weblogpass", admin: true )
    
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get "/signup"
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count', 1) do
      post users_url, params: { user: {username: "James", email: 'james@doe.com', password: "jamespass"  } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
     sign_in_as(@user)
    patch user_url(@user), params: { user: { username: "James"  } }
    assert_redirected_to user_url(@user)
  end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user)
  #   end

  #   assert_redirected_to users_url
  # end
end
