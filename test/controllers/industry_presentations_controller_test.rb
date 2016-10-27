require 'test_helper'

class IndustryPresentationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @industry_presentation = industry_presentations(:one)
  end

  test "should get index" do
    get industry_presentations_url
    assert_response :success
  end

  test "should get new" do
    get new_industry_presentation_url
    assert_response :success
  end

  test "should create industry_presentation" do
    assert_difference('IndustryPresentation.count') do
      post industry_presentations_url, params: { industry_presentation: { description: @industry_presentation.description, industry_id: @industry_presentation.industry_id, title: @industry_presentation.title, user_id: @industry_presentation.user_id } }
    end

    assert_redirected_to industry_presentation_url(IndustryPresentation.last)
  end

  test "should show industry_presentation" do
    get industry_presentation_url(@industry_presentation)
    assert_response :success
  end

  test "should get edit" do
    get edit_industry_presentation_url(@industry_presentation)
    assert_response :success
  end

  test "should update industry_presentation" do
    patch industry_presentation_url(@industry_presentation), params: { industry_presentation: { description: @industry_presentation.description, industry_id: @industry_presentation.industry_id, title: @industry_presentation.title, user_id: @industry_presentation.user_id } }
    assert_redirected_to industry_presentation_url(@industry_presentation)
  end

  test "should destroy industry_presentation" do
    assert_difference('IndustryPresentation.count', -1) do
      delete industry_presentation_url(@industry_presentation)
    end

    assert_redirected_to industry_presentations_url
  end
end
