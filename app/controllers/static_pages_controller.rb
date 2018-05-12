class StaticPagesController < ApplicationController
  def home
  	@posts = Post.where(id:[1,12,14,20,26,32,37,46,54,59])
  end

  def about
  	@posts = Post.where(id:[1,12,14,20,26,32,37,46,54,59])
  end

  def contact
  end
end
