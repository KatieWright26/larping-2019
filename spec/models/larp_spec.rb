# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Larp, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user) }
  let!(:larps) { FactoryBot.create_list(:larp, 5) }

  describe Larp, '#belongs_to_current_user?(user)' do
    before(:each) do
      larps.each do |l|
        l.update(user_id: user.id)
      end
    end

    it 'returns true if the LARP belongs to the current_user' do
      expect(larps.first.belongs_to_current_user?(user)).to eq true
    end
    it 'returns nil if a user is not signed in' do
      expect(larps.first.belongs_to_current_user?(nil)).to eq false
    end

    it 'returns false if the LARP does not belong to the current_user' do
      expect(larps.first.belongs_to_current_user?(other_user)).to eq false
    end
  end

  describe Larp, '#larp_created_within_a_week?' do
    before(:each) do
      larps.first(3).each do |l|
        l.update(created_at: 8.days.ago)
      end
    end
    it 'returns LARPs that have been published in the last week' do
      expect(larps.first.larp_created_within_a_week?).to eq false
      expect(larps.last.larp_created_within_a_week?).to eq true
    end
  end

  describe Larp, '#published_characters' do
    let!(:characters) do
      FactoryBot.create_list(
        :character,
        3,
        larp: larps.first
      )
    end
    it 'returns only published characters of a given LARP' do
      expect(larps.first.published_characters.count).to eq 0
    end
  end
end
