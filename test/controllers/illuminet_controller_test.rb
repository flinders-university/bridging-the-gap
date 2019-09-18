require 'test_helper'

class IlluminetControllerTest < ActionDispatch::IntegrationTest
  test "should get polymer" do
    get illuminet_polymer_url
    assert_response :success
  end

  test "should get take" do
    get illuminet_take_url
    assert_response :success
  end

  test "should get save" do
    get illuminet_save_url
    assert_response :success
  end

end
