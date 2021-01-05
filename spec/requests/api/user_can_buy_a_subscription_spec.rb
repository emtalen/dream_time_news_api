RSpec.describe 'POST /api/subscriptions', type: :request do
  let(:user) { create(:user) }
  let(:user_headers) { user.create_new_auth_token}

  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:valid_stripe_token) { stripe_helper.generate_card_token }

  before(:each) { StripeMock.start }
  after(:each) { StripeMock.stop }

  describe 'successfully' do
    before do
      post '/api/subscriptions',
      params: {
        stripeToken: valid_stripe_token
      },
      headers: user_headers
    end

    it 'is expected to return a 201 response status' do
      expect(response).to have_http_status 201
    end

    it 'is expected to return a success message' do
      expect(response_json['message']).to eq 'You are now a subscriber!'
    end

    it 'is expected to make user a subscriber' do
      expect(user.role?).to eq 'subscriber'
    end
  end
end