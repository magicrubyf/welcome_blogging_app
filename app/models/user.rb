class User < ApplicationRecord

  has_many :posts

  extend FriendlyId
  friendly_id :name, use: :slugged
  def should_generate_new_friendly_id?
    name_changed?
  end

  validates :uid, :name, :picture , presence: true

  def total_posts
    posts.count
  end

  private

  def self.find_or_create_from_auth_hash(auth_hash)
    graph=Koala::Facebook::API.new(auth_hash['credentials']['token'])
    user=find_or_create_by(uid: auth_hash['uid']).tap do |user|
        user.name= auth_hash['info']['name']
        user.picture=graph.get_object("me",{fields:"picture.type(normal){url}"})["picture"]["data"]["url"]
        user.save!
    end
  end

  def self.extend_auth(token)
    oauth = Koala::Facebook::OAuth.new(ENV['APP_ID'],ENV['APP_SECRET'])
    return oauth.exchange_access_token(token)
  end


end
