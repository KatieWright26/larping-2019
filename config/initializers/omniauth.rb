Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], {
    :scope => "userinfo.email, userinfo.profile",
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50,
    :provider_ignores_state => true,
    :token_param => { parse: :json }
  }
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET_ID']
end

OmniAuth.config.allowed_request_methods = [:post, :get]
