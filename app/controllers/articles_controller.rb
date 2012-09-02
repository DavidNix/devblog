class ArticlesController < ApplicationController
  def index
  	@articles = Post.published_with_pagination(params[:page])

  	respond_to do |format|
  		format.html
  		format.atom
  	end

  end

  def show
  	@article = Post.find(params[:id])
  	@article.increment_read_count! unless admin_signed_in?
  end
end
