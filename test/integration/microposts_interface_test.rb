require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:masa)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'

    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, micropost: { content: "" }
    end
    assert_select 'div#error_explanation'

    # Valid submission
    content = "This micropost really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, micropost: { content: content, picture: picture }
    end
    assert assigns(:micropost).picture?, "This micropost should have a picture"
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body

    # Delete a post.
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end

    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  test "micropost sidebar count" do
    # User with many microposts
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body

    # User with zero microposts
    other_user = users(:mallory)
    log_in_as(other_user)
    get root_path
    assert_match "0 microposts", response.body, "Should be plural"

    # User with one micropost
    other_user.microposts.create!(content: "My first micropost")
    get root_path
    assert_match /\W[1] micropost\W/, response.body, "Should be singular"
  end
end
