module ApplicationHelper
  def profile_image(user, options = {})
    size = case options[:size]
           when 'large'
             'w-20 h-20'
           when 'small'
             'w-10 h-10'
           else
             'w-14 h-14'
           end

    classes = "#{size} flex-skrink-0 rounded-full border-2 border-white"
    if user.profile_image.attached?
      image_tag user.profile_image, class: classes
    else
      # https://waifu.now.sh/type/endpoint
      image_tag 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/a48a90ef-2397-442c-91db-ca90c96598d7/d57a874-6a1a2aea-4cb1-41fa-9af8-ef9cb85dc976.jpg/v1/fill/w_1131,h_707,q_70,strp/akatsuki_wallpaper_by_iquantum_d57a874-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTIwMCIsInBhdGgiOiJcL2ZcL2E0OGE5MGVmLTIzOTctNDQyYy05MWRiLWNhOTBjOTY1OThkN1wvZDU3YTg3NC02YTFhMmFlYS00Y2IxLTQxZmEtOWFmOC1lZjljYjg1ZGM5NzYuanBnIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.IKQH40Nzd4Rc_E9_aTPR3Pxff7umq_o--omefcIzILU',
                class: classes
    end
  end
end
