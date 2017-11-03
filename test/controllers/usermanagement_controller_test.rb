require 'test_helper'

class UsermanagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index.html" do
    get usermanagement_index.html_url
    assert_response :success
  end

end
