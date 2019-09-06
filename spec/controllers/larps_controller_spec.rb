# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LarpsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:larp) { FactoryBot.create(:larp, user: user) }

  describe 'LARPs#index' do
    it 'a user can view a list of LARPs' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'LARPs#show' do
    it 'shows a LARP' do
      get :show, params: { id: larp.id }
      expect(response.status).to eq 200
    end
  end

  describe 'LARPs#edit' do
    it 'a user must be signed in to create a LARP' do
      get :edit, params: { id: larp.id }
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end

    it 'a user must own the LARP to edit it' do
    end

    it 'returns the edit view' do
    end
  end

  describe 'LARPs#update' do
    it 'a user must be signed in to create a LARP' do
      get :update, params: { id: larp.id, larp: { title: 'A brand new title' } }
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end

    it 'a user must own the LARP they are trying to edit' do
      get :update, params: { id: larp.id, larp: { title: 'A brand new title' } }
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end
  end

  describe 'LARPs#new' do
    it 'a user must be signed in to create a LARP' do
      get :new
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end
  end

  describe 'LARPs#create' do
    let!(:params) do
      {
        larp: {
          title: 'MyString',
          description: 'MyString',
          start_date: Time.now + 10
        }
      }
    end

    it 'a user must be signed in to create a LARP' do
      get :create, params: params
      expect(response.status).to eq 302
      expect(response).to redirect_to root_path
    end
  end
end
