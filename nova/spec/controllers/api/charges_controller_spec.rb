# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ChargesController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    subject { get :index }

    context 'without logged in' do
      it { is_expected.to have_http_status(:unauthorized) }
    end

    context 'with logged in' do
      before { login!(user) }

      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { amount: 3000 } }

    context 'without logged in' do
      it { is_expected.to have_http_status(:unauthorized) }
    end

    context 'with logged in' do
      before do
        create(:credit_card, user: user, source: stripe.generate_card_token)
        login!(user)
      end

      it { is_expected.to have_http_status(:created) }
    end
  end
end
