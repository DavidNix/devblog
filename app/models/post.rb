class Post < ActiveRecord::Base
  attr_accessible :content, :permalink, :release_date, :teaser, :title

  before_validation { |post| post.permalink = permalink.parameterize }

  validates :title, presence: true
  validates :teaser, presence: true
  validates :content, presence: true
  validates :release_date, presence: true

  # because of overriding find method, permalink cannot begin with a number or it will think it's an id
  validates_format_of :permalink, :without => /^\d/, message: "can't begin with a number."
  validates :permalink, presence: true, uniqueness: { case_sensitive: false }

  # override find method to find by permalink for the articles pages
  # Databases give the id of 1 to the first record, and Ruby converts strings starting with a letter to 0
  def self.find(input)
  	if input.to_i != 0
      super
    else
      find_by_permalink(input)
    end
  end

  def to_param
  	self.permalink
  end

  def published_date 
  	self.release_date.strftime("%B %-d, %Y")
  end

  # pagination
  self.per_page = 20

  def self.published
  	Post.where('release_date <= ?', Time.now)
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

