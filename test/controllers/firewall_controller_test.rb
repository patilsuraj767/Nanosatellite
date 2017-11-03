require 'test_helper'

class FirewallControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get firewall_index_url
    assert_response :success
  end

end
