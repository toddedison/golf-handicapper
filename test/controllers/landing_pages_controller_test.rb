require 'test_helper'

class LandingPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "Home | The Golf Handicapper"
  end

  test "should get help" do
    get landing_pages_help_path
    assert_response :success
    assert_select "title", "Help | The Golf Handicapper"
  end

  test "should get about" do
    get landing_pages_about_path
    assert_response :success
    assert_select "title", "About | The Golf Handicapper"
  end

  test "should get privacy" do
    get landing_pages_privacy_path
    assert_response :success
    assert_select "title", "Privacy | The Golf Handicapper"
  end


end
