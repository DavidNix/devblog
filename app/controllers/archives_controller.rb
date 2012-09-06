class ArchivesController < ApplicationController
  def index
  	@posts = Post.published

  	@post_months = @posts.group_by { |t| t.release_date.beginning_of_month }
  end
end
