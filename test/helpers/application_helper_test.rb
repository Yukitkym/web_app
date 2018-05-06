require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,          "Photravel"
    assert_equal full_title("About"), "About | Photravel"
  end
end