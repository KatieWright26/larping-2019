# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LarpHelper, type: :helper do
  include Devise::Test::ControllerHelpers

  let!(:user) { FactoryBot.create(:user) }
  let!(:larp) { FactoryBot.create(:larp, user: user) }
  let!(:old_larp) { FactoryBot.create(:larp, created_at: 1.year.ago) }

  describe '#display_new_badge' do
    it 'returns false if larp is more than 1 week old' do
      expect(display_new_badge(old_larp)).to eq false
    end

    it 'returns true of larp is less than 1 week old' do
      expect(display_new_badge(larp))
        .to eq content_tag(:i, content_tag(:span, 'new'), class: 'badge--new')
    end
  end

  describe '#display_ownership_badge' do
    it 'returns true if current_user is viewing their own larp' do
      expect(display_ownership_badge(old_larp, user)).to eq false
    end

    it 'returns false for larps not belonging to the current user' do
      expect(display_ownership_badge(larp, user))
        .to eq content_tag(:i, nil, class: 'badge--owner')
    end
  end
end
