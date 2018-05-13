class PostsController < ApplicationController
  before_action :logged_in_user,   only: [:create, :destroy]
  before_action :change_post_user, only: [:edit, :destroy]

  def index
    @posts = Post.paginate(page: params[:page], :per_page => 16)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
  	@post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿が作成されました"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "投稿が更新されました"
      redirect_to post_url
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿が削除されました"
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

    # postを変更出来るユーザーかどうか確認
    def change_post_user
      @post = Post.find(params[:id])
      @my_post = current_user.posts.find_by(id: params[:id])
      redirect_to(root_url) unless !@my_post.nil? || current_user.admin?
    end
end
