require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  context 'relations' do
    it { should have_many(:categories) }
    it { should have_many(:accounts) }
    it { should have_one(:refresh_token) }
  end

  context 'validations' do
    describe '#name' do
      it { should validate_presence_of(:name) }
    end

    describe '#email' do
      let(:invalid_emails) do
        [
          'plinaddress',
          '#@%^%#$@#$@#.co',
          '@domain.com',
          'Joe Smith <email@domain.com>',
          'email.domain.com',
          'email@domain@domain.com',
          '.email@domain.com',
          'email.@domain.com',
          'email..email@domain.com',
          '„ÅÇ„ÅÑ„ÅÜ„Åà„Åä@domain.com',
          'email@domain.com (Joe Smith)',
          'email@domain',
          'email@-domain.com',
          'email@domain.web',
          'email@111.222.333.44444',
          'email@domain..com'
        ]
      end

      it { should validate_presence_of(:email) }
      it { should_not allow_values(invalid_emails).for(:email) }
    end
  end
end
