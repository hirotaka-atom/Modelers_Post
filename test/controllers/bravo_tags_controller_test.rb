require "test_helper"

class BravoTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bravo_tags_index_url
    assert_response :success
  end
end
