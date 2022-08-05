module ProfileHelper
  def following?(user)
    current_user&.followees&.include?(user)
    # just checking if im following the other user or not
  end
end
