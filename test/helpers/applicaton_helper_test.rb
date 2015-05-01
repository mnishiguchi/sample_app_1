require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    # With no argument.
    assert_equal full_title,            "Sample App 1"
    # With an argument.
    assert_equal full_title("Contact"), "Contact | Sample App 1"
  end
end
