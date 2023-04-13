require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:todd)
    @micropost = @user.microposts.build(course: "Lorem ipsum", game_date: "9/23/2017", slope: 117,  rating: 9.99, score: 87 )
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "course should be present" do
   @micropost.course = "   "
   assert_not @micropost.valid?
  end

  test "course should be at most 40 characters" do
    @micropost.course = "a" * 41
    assert_not @micropost.valid?
  end

  test "game date should be present" do
   @micropost.game_date = "   "
   assert_not @micropost.valid?
  end

  test "game date should be at most 40 characters" do
    @micropost.game_date = "a" * 41
    assert_not @micropost.valid?
  end

  test "slope should be present" do
   @micropost.slope = nil
   assert_not @micropost.valid?
  end

  test "slope should be numeric" do
   @micropost.slope.is_a? Numeric
   assert @micropost.valid?
  end

  test "rating should be numeric" do
   @micropost.rating.is_a? Numeric
   assert @micropost.valid?
  end

  test "score should be numeric" do
   @micropost.score.is_a? Numeric
   assert @micropost.valid?
  end

  test "rating should be present" do
   @micropost.rating = nil
   assert_not @micropost.valid?
  end

  test "score should be present" do
   @micropost.score = nil
   assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end
