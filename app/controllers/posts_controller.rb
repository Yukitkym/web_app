class PostsController < ApplicationController
  before_action :logged_in_user,   only: [:create, :destroy]
  before_action :delete_post_user, only: :destroy
  # before_action :correct_user,   only: :destroy

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
  	@post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:content, :picture, :place)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    # postを削除出来るユーザーかどうか確認
    def delete_post_user
      @post = Post.find(params[:id])
      @my_post = current_user.posts.find_by(id: params[:id])
      redirect_to(root_url) unless !@my_post.nil? || current_user.admin?
    end
end
