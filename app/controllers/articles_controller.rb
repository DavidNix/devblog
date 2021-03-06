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
    raise ActiveRecord::RecordNotFound if @article.nil?
  	if @article.is_published?

      @article.increment_read_count! unless admin_signed_in?

    else
      # redirect if post is not published yet
      # could happen if someone guesses the correct permalink and manually types in the URL
  	  render "error/error_404", status: 404 unless admin_signed_in?
    end

  end
end
