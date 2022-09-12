module ApplicationHelper
  def avatar_for(user, options = { size: '300x300' })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    robot_url = "https://robohash.org/#{hash}.png/bgset_any?size=#{size}"
    image_tag(robot_url, alt: user.username, class: "rounded-circle shadow mx-auto d-block")

  end
end
