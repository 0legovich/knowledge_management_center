require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get all" do
    get organizations_all_url
    assert_response :success
  end

end
