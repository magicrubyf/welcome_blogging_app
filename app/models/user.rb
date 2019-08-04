class User < ApplicationRecord

  has_many :posts

  def self.find_or_create_from_auth_hash(auth_hash)
    #find_or_create_user
    user=find_or_create_by(uid: auth_hash['uid']) do |user|
        user.name= auth_hash['info']['name']
        user.auth_key= auth_hash['credentials']['token']
        user.auth_expires_at= auth_hash['credentials']['expires_at']
    end
    #update auth attributes when token is expired
    if Time.at(user.auth_expires_at) < Time.now
      user.auth_key= auth_hash['credentials']['token']
      user.auth_expires_at= auth_hash['credentials']['expires_at']
      user.save!
      user
    else
      user
    end
  end

  def picture(size)
    graph = Koala::Facebook::API.new(auth_key)
    picture=graph.get_object("me",{fields:"picture.type(#{size}){url}"})
    picture["picture"]["data"]["url"]
  end

  def total_posts
    posts.count
  end

end
