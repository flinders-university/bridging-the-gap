require 'test_helper'

class UsertoolsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get usertools_search_url
    assert_response :success
  end

  test "should get new" do
    get usertools_new_url
    assert_response :success
  end

  test "should get create" do
    get usertools_create_url
    assert_response :success
  end

  test "should get update" do
    get usertools_update_url
    assert_response :success
  end

  test "should get manage" do
    get usertools_manage_url
    assert_response :success
  end

end
