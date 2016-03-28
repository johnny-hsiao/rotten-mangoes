class Movie < ActiveRecord::Base
  has_many :reviews

  validates_presence_of :title, :director, :description, :poster_image_url, :release_date
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validate :release_date_is_in_the_past

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
