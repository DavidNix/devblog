class Post < ActiveRecord::Base
  attr_accessible :content, :permalink, :release_date, :teaser, :title, :read_count, :publish_ready

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

  def increment_read_count!
    self.read_count += 1
    self.save validate: false
  end

  def is_published?
    if self.publish_ready == true && self.release_date <= Time.now
      true
    else
      false
    end
  end

  # pagination
  self.per_page = 10

  def self.ready_to_publish
    Post.where('release_date <= ? AND publish_ready = ?', Time.now, true)
  end

  def self.published
  	Post.ready_to_publish.order('release_date desc')
  end

  def self.published_with_pagination(page_num, per_page=5)
  	Post.published.paginate(page: page_num, per_page: per_page)
  end

  # methods for sidebars

  def self.recent_articles(num=5)
    Post.published.limit(num)
  end

  def self.popular_articles(num=5)
    Post.ready_to_publish.order('read_count desc, release_date desc').limit(num)
  end

  def self.future_articles(num=3)
    Post.where('release_date > ? AND publish_ready = ?', Time.now, true).order('release_date asc').limit(num)
  end

end
# == Schema Information
#
# Table name: posts
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  release_date  :datetime
#  teaser        :text(255)
#  content       :text
#  permalink     :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  read_count    :integer         default(0)
#  publish_ready :boolean         default(FALSE)
#

