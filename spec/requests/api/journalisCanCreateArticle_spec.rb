RSpec.describe Api::V1::PerformanceDataController, type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'POST "/api/v1/performance_data"' do
      before do
          post '/api/
      end

      it 'returns a 200 response status' do
          expect(response).to have_http_status 200
      end

      it 'successfully creates a data entry' do
          entry = PerformanceData.last
          expect(entry.data).to eq 'message' => 'Average'
      end
  end

  describe 'GET /api/v1/performance_data' do 
      let!(:existing_entries) do 
          5.times do 
              create(:performance_data,
              data: { message: 'Avarage' },
              user: user )
          end
      end

      before do 
          get '/api/v1/performance_data', headers: headers
      end

      it 'returns a 200 response status' do 
          expect(response).to have_http_status 200
      end

      it 'returns a collection of perfomance data' do 
          expect(response_json['entries'].count).to eq 5
      end
  end
end