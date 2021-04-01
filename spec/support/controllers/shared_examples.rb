RSpec.shared_context 'when the user is not authenticated' do
  context 'when the given access token is invalid' do
    let(:headers) { { 'Authorization' => 'Bearer invalid_token' } }
    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(response_body).to include('message' => 'Unauthorized') }
  end
end
