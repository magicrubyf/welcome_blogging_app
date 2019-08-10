module PostsHelper

  def title
    if params[:hashtags]
        "Posts with tags " + params[:hashtags]
      else
      "Posts by everyone!"
    end
  end

end
