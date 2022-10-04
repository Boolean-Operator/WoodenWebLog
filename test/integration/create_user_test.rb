require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.create(username: "JohnDoe", email: 'john@doe.com', password: "weblogpass")

  end

  test "get signup form and create new user" do
    get "/signup"
    assert_response :success
    assert_difference('User.count', 1) do
      post users_url, params: { user: {username: "James", email: 'james@doe.com', password: "jamespass"  } }
    end
    follow_redirect!
    assert_response :success
    assert_select "h1", "James's profile"
  end

  test "get signup form and reject invalid user submission" do
    get "/signup"
    assert_response :success
    assert_no_difference('User.count') do
      post users_url, params: { user: {username: nil, email: 'james@doe.com', password: "jamespass"  } }
    end
    assert_match "The following errors prevented" ,response.body
    assert_match "Username is too short" ,response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    
  end

  
end
