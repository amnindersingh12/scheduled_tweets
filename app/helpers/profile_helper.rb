module ProfileHelper
  def following?(user)
    current_user&.followees&.include?(user)
  end
end
