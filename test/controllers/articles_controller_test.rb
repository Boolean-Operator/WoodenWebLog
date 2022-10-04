require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "JohnDoe", email: "john@doe.com", password: 'password')
    @article = Article.create(title: "Test Article", description: "Vague description of test article", user_id: @user.id )
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should create article" do
    sign_in_as(@user)
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: {title: "Untested Article", description: "Even more vague description", user_id: 1  } }
    end
    assert_redirected_to article_url(Article.last)
  end


  test "should get edit" do
    sign_in_as(@user)
    get edit_article_url(@article)
    assert_response :success
  end
  
  test "should update article" do
    sign_in_as(@user)
    patch article_url(@article), params: { article: { title: "Edited Test Article" } }
    assert_redirected_to article_url(@article)
  end
  
  test "should destroy article" do
    sign_in_as(@user)
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
