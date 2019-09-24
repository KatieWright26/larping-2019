# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }

  describe 'GET#show' do
    it 'returns the profile page of a user' do
      get :show, params: { id: user.id }

      expect(response.status).to eq 200
      expect(response).to render_template :show
    end
  end
end
