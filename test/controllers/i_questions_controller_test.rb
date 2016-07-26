require 'test_helper'

class IQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @i_question = i_questions(:one)
  end

  test "should get index" do
    get i_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_i_question_url
    assert_response :success
  end

  test "should create i_question" do
    assert_difference('IQuestion.count') do
      post i_questions_url, params: { i_question: { comment: @i_question.comment, description: @i_question.description, enabled: @i_question.enabled, grouping_value: @i_question.grouping_value, survey_id: @i_question.survey_id, type: @i_question.type } }
    end

    assert_redirected_to i_question_url(IQuestion.last)
  end

  test "should show i_question" do
    get i_question_url(@i_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_i_question_url(@i_question)
    assert_response :success
  end

  test "should update i_question" do
    patch i_question_url(@i_question), params: { i_question: { comment: @i_question.comment, description: @i_question.description, enabled: @i_question.enabled, grouping_value: @i_question.grouping_value, survey_id: @i_question.survey_id, type: @i_question.type } }
    assert_redirected_to i_question_url(@i_question)
  end

  test "should destroy i_question" do
    assert_difference('IQuestion.count', -1) do
      delete i_question_url(@i_question)
    end

    assert_redirected_to i_questions_url
  end
end
