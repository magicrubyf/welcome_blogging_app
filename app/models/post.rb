class Post < ApplicationRecord
  after_update :delete_any_old_hashtags_after_update
  after_commit :create_hashtags, on: [:create, :update]

  belongs_to :user
  has_one_attached :picture
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags , through: :post_hashtags

  validates :title, presence: true, length: {minimum:5, maximum:30}
  validates :body, presence: true, length: {minimum:30, maximum:3000}
  validate :picture_presence
  validate :picture_size

  extend FriendlyId
  friendly_id :title, use: :slugged
  def should_generate_new_friendly_id?
    title_changed?
  end




  def picture_presence
    if !picture.attached?
      picture.purge
      errors[:base] << 'Picture must be present.'
    end
  end

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

  def delete_any_old_hashtags_after_update
    if hashtags_to_delete.empty?
      post_hashtags.each do |post_hashtag|
        post_hashtag.destroy
      end
    else
      hashtags_to_delete.each do |name|
        hashtag=Hashtag.find_by(name: name)
        PostHashtag.find_by(hashtag_id: hashtag.id, post_id: id).destroy
      end
    end
  end

  def create_hashtags
    hashtags_from_post_body.uniq.each do |name|
      if Hashtag.exists?(name: name)
        unless hashtags.exists?(name: name)
        old_hashtag=Hashtag.where(name: name).first
        PostHashtag.create(post_id: id, hashtag_id: old_hashtag.id)
        end
      else
        hashtags.create(name: name)
      end
    end
  end

  def hashtags_from_post_body
    body.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end

  def previous_hashtags
    hashtags.map {|hashtag| hashtag.name}
  end

  def hashtags_to_delete
    previous_hashtags - hashtags_from_post_body
  end

end
