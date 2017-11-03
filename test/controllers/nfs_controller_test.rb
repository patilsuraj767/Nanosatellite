require 'test_helper'

class NfsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nfs_index_url
    assert_response :success
  end

end
