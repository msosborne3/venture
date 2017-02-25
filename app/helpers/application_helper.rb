module ApplicationHelper
  # Converts a date to 'Month day, year' for example 'February 23, 2017'
  def to_date(date)
    date.strftime("%B %e, %Y")
  end

  # returns the number of followers a user has. For example '86 followers'
  def display_followers(user_id)
    user = User.find_by(id: user_id)
    num = user.followers.length
    return "#{num} followers"
  end

  # returns the number of users that one is following. For example '103 following'
  def display_following(user_id)
    user = User.find_by(id: user_id)
    num = user.following.length
    return "#{num} following"
  end
end
