require "test_helper"

class DayMarkingsControllerTest < ActionDispatch::IntegrationTest
  test "should get toggle" do
    get day_markings_toggle_url
    assert_response :success
  end
end
