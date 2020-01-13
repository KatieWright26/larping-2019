# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CharacterHelper, type: :helper do
  include Devise::Test::ControllerHelpers

  let!(:user) { FactoryBot.create(:user) }
  let!(:new_user) { FactoryBot.create(:user) }
  let!(:larp) { FactoryBot.create(:larp, user: user) }
  let!(:character) { FactoryBot.create(:character, larp: larp) }

  describe '#apply_or_edit_character_button' do
    it 'shows the edit button if user is owner' do
      sign_in user
      expect(apply_or_edit_character_button(larp, character, user))
        .to include 'Manage Character'
    end

    it 'shows the apply button if user is not owner' do
      sign_in new_user
      expect(apply_or_edit_character_button(larp, character, new_user))
        .to include 'Apply'
    end

    it 'shows nothing if the user is not signed in' do
      expect(apply_or_edit_character_button(larp, character, nil)).to be nil
    end
  end
end
