require 'rails_helper'

RSpec.describe Activity, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:category).optional }
  end

  context 'validations' do
    describe '#amount' do
      it { should validate_presence_of(:amount) }
      it { should validate_numericality_of(:amount) }
    end

    describe '#description' do
      it { should validate_presence_of(:description) }
    end

    describe '#origin' do
      it { should validate_presence_of(:origin) }
      it { should define_enum_for(:origin) }
    end
  end

  context 'delegators' do
    it { should delegate_method(:id).to(:category).with_prefix }
    it { should delegate_method(:description).to(:category).with_prefix }
    it { should delegate_method(:to_response).to(:category).with_prefix }
  end

  describe 'to_response' do
    let(:activity) { create(:activity) }

    it do
      expect(activity.to_response).to include('id' => activity.id)
        .and include('description' => activity.description)
        .and include('amount' => activity.amount.to_s)
        .and include('recurrent' => activity.recurrent)
        .and include('paid_at' => activity.paid_at.to_time.iso8601)
        .and include('expires_at' => activity.expires_at.to_time.iso8601)
        .and include('category' => activity.category.to_response)
    end
  end
end
