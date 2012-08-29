class ArticlesController < ApplicationController
  def index
  	@articles = Post.published_with_pagination(params[:page])
  end

  def show
  	@article = Post.find(params[:id])
  	@article.read_count +=1 unless admin_signed_in?
  end
end
