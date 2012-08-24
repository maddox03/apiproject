class Page < ActiveRecord::Base
  attr_accessible :title, :content, :published_on
  
  validates_presence_of :title, :content
  
  scope :published, where("published_on is not null").order("published_on DESC")
  scope :unpublished, where("published_on is null").order("published_on DESC")
  
  def total_words
    return self.title.scan(/\S+/).size + self.content.scan(/\S+/).size
  end
  
  def publish
    self.update_attribute(:published_on, Time.now)
  end
end
