module ApplicationHelper
  def profile_image(user, options = {})
    size = case options[:size]
      when "large"
        "w-20 h-20"
      when "small"
        "w-10 h-10"
      else
        "w-14 h-14"
      end
    classes = "#{size} flex-skrink-0 rounded-full border-2 border-white"

    if user.profile_image.attached?
      image_tag user.profile_image, class: classes
    else
      image_tag "https://raw.githubusercontent.com/creativetimofficial/public-assets/master/soft-ui-dashboard/assets/img/drake.jpg", class: classes
    end
  end
end
