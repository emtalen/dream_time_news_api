RSpec.describe 'POST /api/v2/auth/sign_in', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:admin) { create(:admin) }
  let(:expected_response) do
    {
      'data' => {
        'id' => admin.id, 'uid' => admin.email, 'email' => admin.email,
        'provider' => 'email', 'name' => admin.name, 'allow_password_change' => false
      }
    }
  end
  describe 'with valid credentials' do
    before do 
      post '/api/v2/auth/sign_in',
        params: {
          email: admin.email,
          password: admin.password
        },
        headers: headers
    end

    it 'returns 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns the expected response' do
      expect(response_json).to eq expected_response
    end
  end

  describe 'with invalid password' do
    before do
      post '/api/v2/auth/sign_in',
        params: {
          email: admin.email,
          password: 'wrong_password'
        },
        headers: headers
    end

    it 'returns 401 response status' do
      expect(response).to have_http_status 401
    end

    it 'returns error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end

  describe 'with invalid email' do
    before do
      post '/api/v2/auth/sign_in',
        params: {
          email: 'user@example.com',
          password: admin.password
        },
        headers: headers
    end

    it 'returns 401 response status' do
      expect(response).to have_http_status 401
    end

    it 'returns error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end
end