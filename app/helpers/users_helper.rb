module UsersHelper

  # return the Gravatar image tag for the given user
  def gravatar_for(user)
    # standardize on all lower-case addresses
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end