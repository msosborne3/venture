module ApplicationHelper
  def to_date(date)
    date.strftime("%B %e, %Y")
  end

  def display_followers(user_id)
    user = User.find_by(id: user_id)
    num = user.followers.length
    return "#{num} followers"
  end

  def display_following(user_id)
    user = User.find_by(id: user_id)
    num = user.following.length
    return "#{num} following"
  end
end
