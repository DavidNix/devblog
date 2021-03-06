class PostsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @posts = Post.paginate(page: params[:page], order: 'release_date desc')
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to article_path(@post), notice: 'Post was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to article_path(@post), notice: 'Post was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

end
