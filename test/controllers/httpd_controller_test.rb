require 'test_helper'

class HttpdControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get httpd_index_url
    assert_response :success
  end

end
