require "test_helper"

class ArticleTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: "JohnDoe", email: 'john@doe.com', password: "password" )
    @article = Article.new(title: "New Artcle", description: "Description of New Artcle", user_id: 1)
  end

  test "article should be valid" do
    assert @article.valid?
  end

  test 'title should be present' do
    @article.title = ""
    assert_not @article.valid?
  end
  
  test 'description should be present' do
    @article.description = ""
    assert_not @article.valid?
  end

end
