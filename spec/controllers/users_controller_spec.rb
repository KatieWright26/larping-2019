# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:malicious_user) { FactoryBot.create(:user) }

  describe 'GET#show' do
    it 'returns the profile page of a user' do
      get :show, params: { id: user.id }

      expect(response.status).to eq 200
      expect(response).to render_template :show
    end
  end

  describe 'GET#edit' do
    it 'throws an error if user doesn\'t own profile' do
      sign_in malicious_user
      get :edit, params: { id: user.id }
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end

    it 'throws an error if the user is not signed in' do
      get :edit, params: { id: user.id }
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end

    it 'succeeds if user editing own profile' do
      sign_in user
      get :edit, params: { id: user.id }
      expect(response.status).to eq 200
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH#update' do
    it 'does not update the user profile if not signed in' do
      patch :update, params: {
        id: user.id, user: { name: 'Spec Name' }
      }
      expect(user.name).to_not eq 'Spec Name'
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end

    it 'does not update unowned profiles' do
      sign_in malicious_user
      patch :update, params: { id: user.id, user: { name: 'Spec Name' } }
      expect(user.name).to_not eq 'Spec Name'
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end

    it 'updates the user profile' do
      sign_in user
      patch :update, params: { id: user.id, user: { name: 'Spec Name' } }
      expect(response.status).to eq 302
      expect(response).to redirect_to user_path(user.id)
      user.reload
      expect(user.name).to eq 'Spec Name'
    end
  end
end
