require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "post interface" do
    log_in_as(@user)
    get posts_path
    assert_select 'div.pagination'
    get newpost_path
    assert_select 'input[id="post_content"]'
    assert_select 'input[type="file"]'
    assert_select 'input[id="post_picture"]'
    assert_select 'input[id="post_place"]'
    # 無効な送信
    picture = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpg')
    assert_no_difference 'Post.count' do
      post newpost_path, params: { post: { content: "", picture: picture, place: "America" } }
      post newpost_path, params: { post: { content: "Hello, World", place: "America" } }
      post newpost_path, params: { post: { content: "Hello, World", picture: picture, place: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "Really ties"
    picture = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpg')
    place = "America"
    assert_difference 'Post.count', 1 do
      post newpost_path, params: { post: { content: content, picture: picture, place: place } }
    end
    assert assigns(:post).picture?
    assert_redirected_to root_url
    follow_redirect!
    get posts_path
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
