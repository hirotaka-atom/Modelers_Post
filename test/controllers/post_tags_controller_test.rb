require "test_helper"

class PostTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get post_tags_index_url
    assert_response :success
  end
end
