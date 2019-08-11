require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post=posts(:one)
    file = Rails.root.join('test', 'fixtures', 'files', 'download.png')
    @post.picture.attach(io: File.open(file), filename: 'download.png')
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "should have picture attached" do
    post = Post.new
    post.title = 'Post title somthing'
    post.body= 'Post body Post bodyPost bodyPost bodyPost bodyPost bodyPost bodyPost body'
    post.user_id= User.first.id
    assert_not post.valid?
  end


  test 'title should be present' do
    @post.title=" "
    assert_not @post.valid?
  end

  test 'body should be present' do
    @post.body=" "
    assert_not @post.valid?
  end

  test 'title should be min 5 characters' do
    @post.title="a"*4
    assert_not @post.valid?
  end

  test 'title should be max 30 characters' do
    @post.title="a"*31
    assert_not @post.valid?
  end

  test 'body should be min 30 characters' do
    @post.body="a"*29
    assert_not @post.valid?
  end

  test 'body should be min 3000 characters' do
    @post.body="a"*3001
    assert_not @post.valid?
  end
end
