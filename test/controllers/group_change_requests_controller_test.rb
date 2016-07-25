require 'test_helper'

class GroupChangeRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_change_request = group_change_requests(:one)
  end

  test "should get index" do
    get group_change_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_group_change_request_url
    assert_response :success
  end

  test "should create group_change_request" do
    assert_difference('GroupChangeRequest.count') do
      post group_change_requests_url, params: { group_change_request: { group_id: @group_change_request.group_id, user_id: @group_change_request.user_id } }
    end

    assert_redirected_to group_change_request_url(GroupChangeRequest.last)
  end

  test "should show group_change_request" do
    get group_change_request_url(@group_change_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_change_request_url(@group_change_request)
    assert_response :success
  end

  test "should update group_change_request" do
    patch group_change_request_url(@group_change_request), params: { group_change_request: { group_id: @group_change_request.group_id, user_id: @group_change_request.user_id } }
    assert_redirected_to group_change_request_url(@group_change_request)
  end

  test "should destroy group_change_request" do
    assert_difference('GroupChangeRequest.count', -1) do
      delete group_change_request_url(@group_change_request)
    end

    assert_redirected_to group_change_requests_url
  end
end
