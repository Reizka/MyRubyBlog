require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:testUserOne)
    sign_in @user
    @article = articles(:testArticleOne)
  end

  test "test" do
    assert_response :success
  end

end
