require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @post = posts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong post" do
    log_in_as(users(:lana))
    post = posts(:ants)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end

  test "should get show" do
    get post_path(@post)
    assert_response :success
  end

  test "should delete other post admin user" do
    log_in_as(users(:michael))
    other_post = posts(:ants)
    get post_path(other_post)
    assert_difference 'Post.count', -1 do
      delete post_path(other_post)
    end
  end

  test "should delete my post" do
    log_in_as(users(:archer))
    my_post = posts(:ants)
    get post_path(my_post)
    assert_difference 'Post.count', -1 do
      delete post_path(my_post)
    end
  end

  test "should not delete other post not admin user or current user" do
    log_in_as(users(:lana))
    other_post = posts(:ants)
    get post_path(other_post)
    assert_no_difference 'Post.count' do
      delete post_path(other_post)
    end
    assert_redirected_to root_url
  end

end