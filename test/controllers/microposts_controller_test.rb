require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase

  def setup
    @micropost = microposts(:orange)
  end

  # Authorization (logged-in user)

  test "should redirect create when not logged in" do
    assert_no_difference "Micropost.count" do
      post :create, micropost: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: @micropost
    end
    assert_redirected_to login_url
  end

  # Authorization (correct user)

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:masa))
    micropost_of_someone = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: micropost_of_someone
    end
    assert_redirected_to root_url
  end
end
