class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy

  validates_presence_of :title, :director, :description, :poster_image_url, :release_date
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validate :release_date_is_in_the_past

  mount_uploader :poster_image_url, ImageUploader

  scope :under_90mins,         -> { where("runtime_in_minutes < 90") }
  scope :between_90and120mins, -> { where("runtime_in_minutes BETWEEN 90 AND 120") }
  scope :over_120mins,         -> { where("runtime_in_minutes > 120") }

  def self.search_title(title)
    where("title LIKE ?", "%#{title}%")
  end
  
  def self.search_director(director)
    where("director LIKE ?", "%#{director}%")
  end

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
