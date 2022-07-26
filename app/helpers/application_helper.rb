module ApplicationHelper
  def profile_image(user)
    classes = "w-14 h-14 flex-skrink-0 rounded-full border-2 border-white"
    if user.profile_image.attached?
      image_tag user.profile_image, class: classes
    else
      image_tag "https://raw.githubusercontent.com/creativetimofficial/public-assets/master/soft-ui-dashboard/assets/img/drake.jpg", class: classes
    end
  end
end
