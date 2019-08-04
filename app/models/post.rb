class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  validates :title, presence: true, length: {minimum:5, maximum:30}
  validates :body, presence: true, length: {minimum:30, maximum:3000}
  validate :picture_size


  def picture_size
    if picture.attached?
      if picture.blob.byte_size > 1000000
        picture.purge
        errors[:base] << 'Picture must be max 1mb.'
      elsif !picture.blob.content_type.starts_with?('image/')
        picture.purge
        errors[:base] << 'Wrong format, please choose an image.'
      end
    end
  end


end
