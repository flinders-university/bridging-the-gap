require 'test_helper'

class ResearchScientistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @research_scientist = research_scientists(:one)
  end

  test "should get index" do
    get research_scientists_url
    assert_response :success
  end

  test "should get new" do
    get new_research_scientist_url
    assert_response :success
  end

  test "should create research_scientist" do
    assert_difference('ResearchScientist.count') do
      post research_scientists_url, params: { research_scientist: { enabled: @research_scientist.enabled, public_bio: @research_scientist.public_bio, public_email: @research_scientist.public_email, public_phone: @research_scientist.public_phone, student_group_id: @research_scientist.student_group_id, user_id: @research_scientist.user_id } }
    end

    assert_redirected_to research_scientist_url(ResearchScientist.last)
  end

  test "should show research_scientist" do
    get research_scientist_url(@research_scientist)
    assert_response :success
  end

  test "should get edit" do
    get edit_research_scientist_url(@research_scientist)
    assert_response :success
  end

  test "should update research_scientist" do
    patch research_scientist_url(@research_scientist), params: { research_scientist: { enabled: @research_scientist.enabled, public_bio: @research_scientist.public_bio, public_email: @research_scientist.public_email, public_phone: @research_scientist.public_phone, student_group_id: @research_scientist.student_group_id, user_id: @research_scientist.user_id } }
    assert_redirected_to research_scientist_url(@research_scientist)
  end

  test "should destroy research_scientist" do
    assert_difference('ResearchScientist.count', -1) do
      delete research_scientist_url(@research_scientist)
    end

    assert_redirected_to research_scientists_url
  end
end
