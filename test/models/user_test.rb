require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the user should have a uid,name,picture" do
   user=User.new
   assert_not user.save
 end
end
