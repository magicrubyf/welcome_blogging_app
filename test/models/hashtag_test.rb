require 'test_helper'

class HashtagTest < ActiveSupport::TestCase
  def setup
    @hashtag=hashtags(:one)
  end

  test 'hashtag should be unique' do
    @hashtag.save
    hashtag=hashtags(:two)
    assert_not hashtag.valid?
  end
end
