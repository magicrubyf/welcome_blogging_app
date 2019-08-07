class HashtagsController < ApplicationController

def index
  @hashtags=Hashtag.all.joins(:posts).order(:name).uniq
end

end
