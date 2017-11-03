require 'test_helper'

class SambaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get samba_index_url
    assert_response :success
  end

end
