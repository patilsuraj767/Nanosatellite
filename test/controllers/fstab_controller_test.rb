require 'test_helper'

class FstabControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fstab_index_url
    assert_response :success
  end

end
