RSpec.shared_context 'when the user is not authenticated' do
  context 'when the user is not authenticated' do
    context 'when the given access token is invalid' do
      let(:headers) { { 'Authorization' => 'Bearer invalid_token' } }

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response_body).to include('message' => 'Unauthorized') }
    end

    include_context 'when the Authorization header is missing'
  end
end

RSpec.shared_context 'when the Authorization header is missing' do
  context 'when the Authorization header is missing' do
    let(:headers) { {} }

    it { expect(response).to have_http_status(:bad_request) }
    it do
      expect(response_body).to include('message' => 'Bad Request')
        .and include('errors' => 'Missing Access Token')
    end
  end
end
