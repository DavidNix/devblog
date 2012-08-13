class Post < ActiveRecord::Base
  attr_accessible :content, :permalink, :release_date, :teaser, :title

  before_save { |post| post.permalink = permalink.downcase.strip.gsub(/ +/, "-") }

  validates :title, presence: true
  validates :teaser, presence: true
  validates :content, presence: true
  validates :release_date, presence: true

  # TO DO:  make a good regex for permalinks
  # VALID_PERMALINK_REGEX = /[a-z0-9]+/i
  validates :permalink, presence: true, uniqueness: { case_sensitive: false } #format: { with: VALID_PERMALINK_REGEX }


  def published_date 
  	self.release_date.strftime("%B %-d, %Y")
  end

  # pagination
  self.per_page = 20

  def self.published
  	Post.where('release_date < ?', Time.now)
  end

  def self.published_with_pagination(page_num, per_page=5)
  	Post.published.paginate(page: page_num, order: 'release_date desc', per_page: per_page)
  end

end
# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  release_date :datetime
#  teaser       :text(255)
#  content      :text
#  permalink    :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

