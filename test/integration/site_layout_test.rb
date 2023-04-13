require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'landing_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", landing_pages_help_path
    assert_select "a[href=?]", landing_pages_about_path
    assert_select "a[href=?]", landing_pages_privacy_path
  end
end
