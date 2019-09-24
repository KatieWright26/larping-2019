# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LarpsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:user) { FactoryBot.create(:user) }
  let!(:larp) { FactoryBot.create(:larp, user: user) }

  describe 'GET#index' do
    it 'a user can view a list of LARPs' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET#show' do
    it 'shows a LARP' do
      get :show, params: { id: larp.id }
      expect(response.status).to eq 200
    end
  end

  describe 'GET#edit' do
    context 'a user is not signed in' do
      it 'a user must be signed in to create a LARP' do
        get :edit, params: { id: larp.id }
        expect(response.status).to eq 302
        expect(response).to redirect_to root_path
      end
    end

    context 'a user is signed in' do
      before(:each) do
        sign_in user
      end

      it 'a user must own the LARP to edit it' do
        get :edit, params: { id: larp.id }
        expect(response.status).to eq 200
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH#update' do
    context 'a user is not signed in' do
      it 'a user must be signed in to create a LARP' do
        patch :update, params: { id: larp.id,
                                 larp: { title: 'A brand new title' } }
        expect(response.status).to eq 302
        expect(response).to redirect_to root_path
      end
    end

    context 'a user is signed in' do
      let!(:other_larp) { FactoryBot.create(:larp) }

      before(:each) do
        sign_in user
      end

      it 'a user can edit their own LARP' do
        patch :update, params: { id: larp.id,
                                 larp: { title: 'A brand new title' } }
        expect(response.status).to eq 302
        expect(response).to redirect_to larp_path(larp)
        larp.reload
        expect(larp.title).to eq 'A brand new title'
      end

      it 'a user must own the LARP they are trying to edit' do
        patch :update, params: { id: other_larp.id,
                                 larp: { title: 'A brand new title' } }
        expect(response.status).to eq 302
        expect(response).to redirect_to root_path
        expect(other_larp.title).to_not eq 'A brand new title'
      end
    end
  end

  describe 'GET#new' do
    context 'a user is not signed in' do
      it 'it redirects to home' do
        get :new, params: { user_id: nil }
        expect(response.status).to eq 302
        expect(response).to redirect_to root_path
      end
    end

    context 'a user is signed in' do
      before do
        sign_in user
      end

      it 'it renders new' do
        get :new, params: { user_id: user.id }
        expect(response.status).to eq 200
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST#create' do
    let!(:params) do
      {
        larp: {
          title: 'New LARP',
          description: 'Here is my new LARP',
          start_date: Time.now + 10,
          user_id: user.id
        }
      }
    end

    context 'a user is signed in' do
      before(:each) do
        sign_in user
      end

      it 'creates a new LARP' do
        expect do
          post :create, params: params
        end.to change(Larp, :count).by(1)
        expect(response.status).to eq 302
        expect(response).to redirect_to root_path
      end
    end

    context 'a user is not signed in' do
      it 'redirects to the homepage' do
        expect do
          post :create, params: params
        end.to change(Larp, :count).by(0)
        expect(response.status).to eq 302
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE#destroy' do
    context 'user is signed in' do
      before do
        sign_in user
      end

      it 'deletes a users LARP' do
        expect do
          delete :destroy, params: { id: larp.id }
        end.to change(Larp, :count).by(-1)
        expect(response).to redirect_to larps_path
      end
    end

    context 'user is not signed in' do
      it 'redirects the user to the homepage' do
        expect do
          delete :destroy, params: { id: larp.id }
        end.to change(Larp, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end
