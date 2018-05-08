class StaticPagesController < ApplicationController
  def home
  	@posts = Post.where(id:[1..10])
  end

  def about
  end

  def contact
  end
end
