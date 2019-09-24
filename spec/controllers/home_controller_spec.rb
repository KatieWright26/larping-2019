# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET#index' do
    let!(:larps) { FactoryBot.create_list(:larp, 10) }
    it 'returns all LARPs' do
      get :index

      expect(response).to render_template(:index)

      expect(assigns(:larps)).to eq(larps)
    end
  end
end
