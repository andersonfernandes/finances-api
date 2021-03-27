require 'rails_helper'

RSpec.describe RefreshToken, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    describe '#encrypted_token' do
      subject { build(:refresh_token) }

      it { should validate_uniqueness_of(:encrypted_token) }
    end
  end

  context 'encrypted_token auto generation' do
    subject { described_class.new(user: build(:user)) }

    before { subject.save }

    it 'when saving the subject, the encrypted_token should be auto generated' do
      expect(subject.encrypted_token).not_to be_blank
    end
  end
end
