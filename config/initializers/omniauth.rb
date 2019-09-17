Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], {
    :scope => "email, profile",
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50
  }
  # provider :facebook, "FACEBOOK_KEY", "FACEBOOK_SECRET"
end