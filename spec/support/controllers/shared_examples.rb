RSpec.shared_context 'when the user is not authenticated' do
  context 'when the user is not authenticated' do
    context 'when the given access token is invalid' do
      let(:headers) { { 'Authorization' => 'Bearer invalid_token' } }

      it { expect(response).to have_http_status(:unauthorized) }
      it do
        expect(response_body).to include('message' => 'Unauthorized')
          .and include('errors' => 'Invalid Access Token')
      end
      it { expect(response.headers['WWW-Authenticate']).to include('invalid_token') }
    end

    include_context 'when the Authorization header is missing'
    include_context 'when the access token is expired'
  end
end

RSpec.shared_context 'when the Authorization header is missing' do
  context 'when the Authorization header is missing' do
    let(:headers) { {} }

    it { expect(response).to have_http_status(:unauthorized) }
    it do
      expect(response_body).to include('message' => 'Unauthorized')
        .and include('errors' => 'Missing Access Token')
    end
    it { expect(response.headers['WWW-Authenticate']).to include('invalid_token') }
  end
end

RSpec.shared_context 'when the access token is expired' do
  context 'when the access token is expired' do
    let(:access_token) do
      token = create(:token, expiry_at: 2.days.ago, status: :active)

      JWT.encode(
        token.access_token_payload,
        ENV['SECRET_KEY_BASE']
      )
    end
    let(:headers) { { 'Authorization' => "Bearer #{access_token}" } }

    it { expect(response).to have_http_status(:unauthorized) }
    it do
      expect(response_body).to include('message' => 'Unauthorized')
        .and include('errors' => 'Expired Access Token')
    end
    it { expect(response.headers['WWW-Authenticate']).to include('expired_token') }
  end
end
