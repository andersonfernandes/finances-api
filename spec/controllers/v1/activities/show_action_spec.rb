require 'rails_helper'

RSpec.describe V1::ActivitiesController, '#show', type: :request do
  let(:body) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  let(:activity) { create(:activity, user: user) }

  let(:headers) { authorization_header(user) }

  before { get v1_activity_path(activity), headers: headers }

  include_context 'when the user is not authenticated'

  context 'when the user is authenticated' do
    context 'and the activity exists' do
      it { expect(response).to have_http_status(:ok) }
      it do
        expect(body).to include('id' => activity.id)
          .and include('description' => activity.description)
          .and include('amount' => activity.amount.to_s)
          .and include('recurrent' => activity.recurrent)
          .and include('paid_at' => activity.paid_at.to_time.iso8601)
          .and include('category' => activity.category.to_response)
      end
    end

    context 'and the category does not exist' do
      let(:activity) { -1 }

      it { expect(response).to have_http_status(:not_found) }
      it do
        error_message = "Couldn't find Activity with 'id'=-1"
        expect(body).to include('errors' => error_message)
      end
    end
  end
end
