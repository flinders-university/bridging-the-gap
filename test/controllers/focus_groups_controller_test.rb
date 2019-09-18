require 'test_helper'

class FocusGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @focus_group = focus_groups(:one)
  end

  test "should get index" do
    get focus_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_focus_group_url
    assert_response :success
  end

  test "should create focus_group" do
    assert_difference('FocusGroup.count') do
      post focus_groups_url, params: { focus_group: { name: @focus_group.name, slots: @focus_group.slots, start: @focus_group.start, user_id: @focus_group.user_id } }
    end

    assert_redirected_to focus_group_url(FocusGroup.last)
  end

  test "should show focus_group" do
    get focus_group_url(@focus_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_focus_group_url(@focus_group)
    assert_response :success
  end

  test "should update focus_group" do
    patch focus_group_url(@focus_group), params: { focus_group: { name: @focus_group.name, slots: @focus_group.slots, start: @focus_group.start, user_id: @focus_group.user_id } }
    assert_redirected_to focus_group_url(@focus_group)
  end

  test "should destroy focus_group" do
    assert_difference('FocusGroup.count', -1) do
      delete focus_group_url(@focus_group)
    end

    assert_redirected_to focus_groups_url
  end
end
