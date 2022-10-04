require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "JohnDoe", email: "john@doe.com", password: 'password')
  end

  test "get new article form and create new article" do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: {title: "Integration Testing Article", description: "Very vague description of an article test", user_id: 1}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_select "h2", "Integration Testing Article"
  end

  test "get new article form and reject invalid article submission" do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
    assert_no_difference('Article.count') do
      post articles_url, params: { article: {title: "", description: "Very vague description of an article test", user_id: 1}}
      assert_match "The following errors prevented", response.body
      assert_select 'div.alert'
      assert_select 'h4.alert-heading'
    end    

  end
end
