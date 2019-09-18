require 'test_helper'

class CertificatesControllerTest < ActionDispatch::IntegrationTest
  test "should get conference16" do
    get certificates_conference16_url
    assert_response :success
  end

end
