class User < ApplicationRecord

  has_many :posts

  def self.find_or_create_from_auth_hash(auth_hash)
    graph=Koala::Facebook::API.new(auth_hash['credentials']['token'])
    user=find_or_create_by(uid: auth_hash['uid']) do |user|
        user.name= auth_hash['info']['name']
        user.picture=graph.get_object("me",{fields:"picture.type(normal){url}"})["picture"]["data"]["url"]
    end
  end

  def total_posts
    posts.count
  end

end
