require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admmindoe", email: "admin@example.com",password: "weblogpass", admin: true )
  end

  test "get new category form and create new category" do
    sign_in_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Sports" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    # assert_match "Sports", response.body
    assert_select "h1", "Category: Sports"
    
  end
  
  test "get new category form and reject invalid category submission" do
    sign_in_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: " " } }
    end
    assert_match "following errors prevented", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'

  end
end
