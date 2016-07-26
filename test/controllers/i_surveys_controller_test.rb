require 'test_helper'

class ISurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @i_survey = i_surveys(:one)
  end

  test "should get index" do
    get i_surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_i_survey_url
    assert_response :success
  end

  test "should create i_survey" do
    assert_difference('ISurvey.count') do
      post i_surveys_url, params: { i_survey: { coding_explanation: @i_survey.coding_explanation, description: @i_survey.description, enabled: @i_survey.enabled, form_id: @i_survey.form_id, group_id: @i_survey.group_id } }
    end

    assert_redirected_to i_survey_url(ISurvey.last)
  end

  test "should show i_survey" do
    get i_survey_url(@i_survey)
    assert_response :success
  end

  test "should get edit" do
    get edit_i_survey_url(@i_survey)
    assert_response :success
  end

  test "should update i_survey" do
    patch i_survey_url(@i_survey), params: { i_survey: { coding_explanation: @i_survey.coding_explanation, description: @i_survey.description, enabled: @i_survey.enabled, form_id: @i_survey.form_id, group_id: @i_survey.group_id } }
    assert_redirected_to i_survey_url(@i_survey)
  end

  test "should destroy i_survey" do
    assert_difference('ISurvey.count', -1) do
      delete i_survey_url(@i_survey)
    end

    assert_redirected_to i_surveys_url
  end
end
