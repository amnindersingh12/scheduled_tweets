module ProfileHelper
  def following?(user)
    current_user&.followees&.include?(user)
    # just checking if im(current_user) is following user(user)
  end
end
