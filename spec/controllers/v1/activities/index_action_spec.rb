require 'rails_helper'

RSpec.describe V1::ActivitiesController, '#index', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:activity1) { create(:activity, user: user1) }
  let!(:activity2) { create(:activity, user: user2) }
  let!(:activity3) { create(:activity, user: user1) }

  let(:headers) { authorization_header(user1) }

  before { get v1_activities_path, headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'when have 3 activitiess and 2 belongs to the user' do
      it { expect(response).to have_http_status(:ok) }
      it { expect(body.size).to eq 2 }
      it do
        expect(body.first).to include('id' => activity1.id)
          .and include('description' => activity1.description)
          .and include('amount' => activity1.amount.to_s)
          .and include('recurrent' => activity1.recurrent)
          .and include('paid_at' => activity1.paid_at.to_time.iso8601)
          .and include('category' => activity1.category.to_response)

        expect(body.second).to include('id' => activity3.id)
          .and include('description' => activity3.description)
          .and include('amount' => activity3.amount.to_s)
          .and include('recurrent' => activity3.recurrent)
          .and include('paid_at' => activity3.paid_at.to_time.iso8601)
          .and include('category' => activity3.category.to_response)
      end
    end
  end
end
