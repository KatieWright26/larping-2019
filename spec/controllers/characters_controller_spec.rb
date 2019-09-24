# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CharactersController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET#new' do
    let!(:user) { FactoryBot.create(:user) }
    context 'when a user is not signed in' do
      it 'returns the new template' do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    context 'when a user is signed in' do
      let(:larp) { FactoryBot.create(:larp, user: user) }

      before(:each) do
        sign_in user
      end

      it 'returns an error if there is no associated LARP' do
        get :new
        expect(response).to redirect_to root_path
      end

      it 'returns the new template' do
        user.larps = [larp]
        user.save!
        get :new, params: { larp_id: user.larps.first.id }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST#create' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:larp) { FactoryBot.create(:larp, user: user) }
    let!(:illegal_larp) { FactoryBot.create(:larp) }
    let!(:params) do
      {
        character: {
          name: 'Test Character',
          description: 'Test Description',
          race: 'human',
          occupation: 'Witch',
          larp_id: larp.id
        }
      }
    end
    let!(:invalid_params) do
      {
        character: {
          name: 'Test Character',
          description: 'Test Description',
          race: 'non-human',
          occupation: 'Witch',
          larp_id: illegal_larp.id
        }
      }
    end

    context 'when a user is not signed in' do
      it 'redirects users to the homepage' do
        post :create, params: params
        expect(response).to redirect_to root_path
        expect { post :create, params: params }.to_not change(Character, :count)
      end
    end

    context 'when a user is signed in' do
      before(:each) do
        sign_in user
      end

      it 'creates a character for their own LARP' do
        post :create, params: params
        expect(response).to redirect_to larp_path(larp)
        expect { post :create, params: params }.to change(
          Character,
          :count
        ).by(1)
      end

      it 'throughs an error if the user doesnt own the LARP' do
        post :create, params: invalid_params
        expect(response).to redirect_to root_path
        expect { post :create, params: invalid_params }.to_not change(
          Character,
          :count
        )
      end

      it 'throws errors if params are missing' do
        post :create, params: { character: { larp_id: larp.id } }
        expect(response).to render_template :new
      end

      it 'saves characters as unpublished by default' do
        post :create, params: params
        expect(Character.last.published).to eq false
      end
    end
  end

  describe 'GET#edit' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:larp) { FactoryBot.create(:larp, user: user) }
    let!(:character) { FactoryBot.create(:character, larp: larp) }

    context 'when a user is not signed in' do
      it 'redirects the user to the root path' do
        get :edit, params: { id: character.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'when a user is signed in' do
      before(:each) do
        sign_in user
      end

      it 'successfully calls the edit method' do
        get :edit, params: { id: character.id }
        expect(response).to render_template :edit
      end

      it 'does not render the edit template for characters not owned' do
        get :edit, params: { id: character.id }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH#update' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:larp) { FactoryBot.create(:larp, user: user) }
    let!(:character) { FactoryBot.create(:character, larp: larp) }
    let(:params) do
      {
        id: character.id,
        character: {
          name: 'New Name',
          larp_id: larp.id
        }
      }
    end

    context 'when a user is not signed in' do
      it 'redirects the user to the root path' do
        patch :update, params: params
        expect(response).to redirect_to root_path
      end
    end

    context 'when a user is signed in' do
      before(:each) do
        sign_in user
      end
      it 'successfully calls the update method' do
        patch :update, params: params
        character.reload
        expect(character.name).to eq 'New Name'
        expect(response).to redirect_to larp_path(character.larp_id)
      end
    end
  end

  describe 'DELETE#destroy' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:larp) { FactoryBot.create(:larp, user: user) }
    let!(:character) { FactoryBot.create(:character, larp: larp) }
    let!(:secondary_character) { FactoryBot.create(:character) }

    context 'when a user is signed in' do
      before(:each) do
        sign_in user
      end

      it 'can delete a character that belongs to their LARP' do
        expect do
          delete :destroy, params: { id: character.id }
        end.to change(Character, :count).by(-1)
      end

      it 'cannot delete a character that doesnt belong to them' do
        expect do
          delete :destroy, params: { id: secondary_character.id }
        end.to_not change(Character, :count)
      end
    end

    context 'when a user is not signed in' do
      it 'cannot delete a character' do
        delete :destroy, params: { id: secondary_character.id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
