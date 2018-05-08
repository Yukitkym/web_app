require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    image_path = File.join(Rails.root, "test/fixtures/kitten.jpg")
    @post = @user.posts.build(content: "Lorem ipsum", picture: File.new(image_path))
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 15 characters" do
    @post.content = "a" * 16
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

  test "picture should be present" do
    @post.picture = nil
    assert_not @post.valid?
  end
end