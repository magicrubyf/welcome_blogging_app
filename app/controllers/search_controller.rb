class SearchController < ApplicationController

  def index
    if params[:hashtags].present?
      query=params[:hashtags].scan(/#\w+/).map{|name| name.gsub("#", "")}
      @posts=Post.joins(:hashtags).where(hashtags: {name: query})
      if !@posts.empty?
        @posts=@posts.uniq
        render 'posts/index'
      else
        flash[:danger]="No posts found."
        redirect_to posts_path
      end
    else
      flash[:error]="You have entered an empty search hashtag"
      redirect_to posts_path
    end
  end

end
