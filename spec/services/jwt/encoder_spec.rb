require 'rails_helper'

describe Jwt::Encoder do
  let(:user) { create(:user) }

  subject { described_class.new(user) }

  describe '#call' do
    it 'should return the encoded access_token' do
      expect(subject.call).not_to be_empty
    end

    it 'should create a new Token on the database' do
      expect { subject.call }.to change { Token.count }.by(1)
    end
  end
end
