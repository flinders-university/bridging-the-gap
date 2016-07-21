require 'test_helper'

class MailmergeControllerTest < ActionDispatch::IntegrationTest
  test "should get postmaster" do
    get mailmerge_postmaster_url
    assert_response :success
  end

end
