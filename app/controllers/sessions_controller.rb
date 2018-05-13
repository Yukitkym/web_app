class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user) # チェックボックスがオンのときにユーザーを記憶し、オフのときには記憶しないようにする
        redirect_back_or @user
      else
        message  = "アカウントがアクティブ状態ではありません。"
        message += "メールアドレスをチェックしてアクティブ状態にしてください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレスかパスワードが正しくありません'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
