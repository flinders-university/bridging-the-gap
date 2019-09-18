require 'test_helper'

class MergeAccountWithOauthControllerTest < ActionDispatch::IntegrationTest
  test "should get notice" do
    get merge_account_with_oauth_notice_url
    assert_response :success
  end

end
