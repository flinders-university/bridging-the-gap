require 'test_helper'

class UnitPresentationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @unit_presentation = unit_presentations(:one)
  end

  test "should get index" do
    get unit_presentations_url
    assert_response :success
  end

  test "should get new" do
    get new_unit_presentation_url
    assert_response :success
  end

  test "should create unit_presentation" do
    assert_difference('UnitPresentation.count') do
      post unit_presentations_url, params: { unit_presentation: { title: @unit_presentation.title, user_id: @unit_presentation.user_id } }
    end

    assert_redirected_to unit_presentation_url(UnitPresentation.last)
  end

  test "should show unit_presentation" do
    get unit_presentation_url(@unit_presentation)
    assert_response :success
  end

  test "should get edit" do
    get edit_unit_presentation_url(@unit_presentation)
    assert_response :success
  end

  test "should update unit_presentation" do
    patch unit_presentation_url(@unit_presentation), params: { unit_presentation: { title: @unit_presentation.title, user_id: @unit_presentation.user_id } }
    assert_redirected_to unit_presentation_url(@unit_presentation)
  end

  test "should destroy unit_presentation" do
    assert_difference('UnitPresentation.count', -1) do
      delete unit_presentation_url(@unit_presentation)
    end

    assert_redirected_to unit_presentations_url
  end
end
