require "test_helper"

class RegistersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get registers_new_url
    assert_response :success
  end
end
