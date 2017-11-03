require 'test_helper'

class IscsiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get iscsi_index_url
    assert_response :success
  end

end
