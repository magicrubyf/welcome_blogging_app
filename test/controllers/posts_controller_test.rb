require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get redirect if user not logged in for new post" do
    get new_post_url
    assert_response :redirect
  end
  
end
