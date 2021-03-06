# frozen_string_literal: true

class Users::OmniauthController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.create_with_omniauth(request.env['omniauth.auth'])

    respond_to_callback('google_oauth2')
  end

  def facebook
    @user = User.create_with_omniauth(request.env['omniauth.auth'])

    respond_to_callback('facebook')
  end

  private

  def respond_to_callback(kind)
    if @user.persisted?
      kind = kind == 'facebook' ? 'Facebook' : 'Google'
      set_flash_message(:notice, :success, kind: kind) if
      is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_registration_url
    end
  end
end
