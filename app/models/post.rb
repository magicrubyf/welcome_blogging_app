class Post < ApplicationRecord
  after_commit :create_hashtags, on: [:create, :update]

  belongs_to :user
  has_one_attached :picture
  has_many :post_hashtags
  has_many :hashtags, through: :post_hashtags

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



  private

  def create_hashtags
    hashtags_from_post_body.each do |name|
      if Hashtag.exists?(name: name)
        old_hashtag=Hashtag.where(name: name).first
        PostHashtag.create(post_id: id, hashtag_id: old_hashtag.id)
      else
        hashtags.create(name: name)
      end
    end
  end

  def hashtags_from_post_body
    body.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end

end
