require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get groups_index_url
    assert_response :success
  end

  test "should get adduser" do
    get groups_adduser_url
    assert_response :success
  end

  test "should get update" do
    get groups_update_url
    assert_response :success
  end

end
